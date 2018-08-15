From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
Date: Wed, 15 Aug 2018 02:46:36 +0200
Message-ID: <20180815004636.GB11610@lunn.ch>
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Sender: netdev-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Rob Herring <robh@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-usb@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, Xue Liu <liuxuenetmail@gmail.com>, Ben Whitten <ben.whitten@lairdtech.com>, devicetree@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, Alexander Graf <agraf@suse.de>, "LoRa_Community_Support@semtech.com" <LoRa_Community_Support@semtech.com>, Jian-Hong Pan <starnight@g.ncu.edu.tw>, Stefan Rehm <rehm@miromico.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Andreas

This not my area of expertise. But i wanted to point out that there
exists a mechanism to make the FDTI driver release a port so that it
can be used from user space, e.g. for JTAG. It might be possible to
extend this mechanism to make the FTDI driver perform the registration
to serdev.

It is however not a generic solution.

   Andrew
