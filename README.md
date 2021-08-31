
[![Bonsai Asset Badge](https://img.shields.io/badge/Bonsai-Download%20Me-brightgreen.svg?colorB=89C967&logo=sensu)](https://bonsai.sensu.io/assets/karlvr/sensu-plugins-network-checks)

# Sensu Go Network Checks Plugin

Table of Contents

- [Overview](#overview)
- [Usage examples](#usage-examples)
- [Configuration](#configuration)
  - [Asset registration](#asset-registration)

## Overview

Replacements for [sensu-plugins/sensu-plugins-network-checks](https://github.com/sensu-plugins/sensu-plugins-network-checks)
using Perl rather than Ruby.

This is a work in progress, and only the check(s) that I need are ported. I would welcome ports to Perl that follow a similar approach.

## Configuration

### Asset Registration

Assets are the best way to make use of this plugin. If you're not using an asset, please consider doing so! If you're using sensuctl 5.13 or later, you can use the following command to add the asset: 

`sensuctl asset add karlvr/sensu-plugins-network-checks`

If you're using an earlier version of sensuctl, you can find the asset on the [Bonsai Asset Index](https://bonsai.sensu.io/assets/karlvr/sensu-plugins-network-checks).
