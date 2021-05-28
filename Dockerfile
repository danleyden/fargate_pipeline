ARG BASE_IMAGE=rails:latest

FROM ${BASE_IMAGE}

ENV APP_HOME /app
ENV APP_USER worker
WORKDIR ${APP_HOME}

# Copy the Gemfile
COPY Gemfile ${APP_HOME}/Gemfile
COPY Gemfile.lock ${APP_HOME}/Gemfile.lock

# Install the remaining gems
RUN bundle install

USER ${APP_USER}

# Copy the project over
#COPY --chown=${APP_USER}:${APP_USER} . ${APP_HOME}
COPY . ${APP_HOME}

# Map port 8080 to the outside world (your local computer)
EXPOSE 8080

ENTRYPOINT ["sh", "./entrypoint.sh"]
