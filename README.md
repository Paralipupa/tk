# Info Widget

This project was bootstrapped with [Create React App](https://github.com/facebookincubator/create-react-app).

[CLI tool documentation](https://github.com/facebookincubator/create-react-app/blob/master/packages/react-scripts/template/README.md).


## Install

### Prerequisites

- [Git](https://git-scm.com/downloads)
- [Node.js](https://nodejs.org/en/download/current/)
- [Yarn](https://yarnpkg.com/en/docs/install)

### Keys

In order to access private repositories, add ssh keys to your Gitlab profile following this guide: https://docs.gitlab.com/ce/ssh/README.html

Also this screencast may be useful: https://about.gitlab.com/2014/03/04/add-ssh-key-screencast/

After the keys has been set up, make sure they work properly:

```
ssh -T git@gitlab.com
```
should output:
```
Welcome to GitLab, <Your Name>!
```

### Downloading

If you download sources as zip files from Gitlab UI (not recommended), make sure you also download and extract submodule repositories.

### Fetch sources

- `git clone git@gitlab.com:qborder/info-widget.git`
- `cd info-widget`
- `git submodule update --init --recursive`

### Install dependencies

- `yarn install`

## Build

- `yarn build`

This will create a production build, located at `./build` directory.

## Development

Start development server:

- `yarn start`