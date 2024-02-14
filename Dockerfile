FROM okteto/okteto:2.25.2
ENV OKTETO_ORIGIN github_action

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
