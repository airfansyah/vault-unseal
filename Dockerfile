from --platform=amd64 alpine:3.12.0
MAINTAINER arie.irfansyah@gmail.com
WORKDIR /tmp
ADD https://releases.hashicorp.com/vault/1.12.2/vault_1.12.2_linux_amd64.zip /tmp/
ADD https://releases.hashicorp.com/vault/1.12.2/vault_1.12.2_SHA256SUMS /tmp/
ADD https://releases.hashicorp.com/vault/1.12.2/vault_1.12.2_SHA256SUMS.sig /tmp/


RUN apk --update add --virtual verify gpgme \
  && gpg --keyserver keyserver.ubuntu.com --recv-key 0x72D7468f \
  && gpg --verify /tmp/vault_1.12.2_SHA256SUMS.sig \
  && apk del verify \
  && cat vault_1.12.2_SHA256SUMS | grep linux_amd64 | sha256sum -c \
  && unzip vault_1.12.2_linux_amd64.zip \
  && mv vault /usr/local/bin/ \
  && rm -rf /tmp/* \
  && rm -rf /var/cache/apk/*


COPY vault-unseal.sh /vault-unseal.sh
RUN ["chmod", "+x", "/vault-unseal.sh"]
ENTRYPOINT ["sh","/vault-unseal.sh"]
