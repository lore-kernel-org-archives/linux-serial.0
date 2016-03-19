From: Mathieu OTHACEHE <m.othacehe@gmail.com>
Subject: Re: [PATCH v3] tty: serial: 8250: add MOXA Smartio MUE boards support
Date: Sat, 19 Mar 2016 10:07:23 +0100
Message-ID: <20160319090723.GA8678@gmail.com>
References: <1456341022-8897-1-git-send-email-m.othacehe@gmail.com>
 <56E68636.8000002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56E68636.8000002@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, heikki.krogerus@linux.intel.com, hpeter@gmail.com, soeren.grunewald@desy.de, udknight@gmail.com, JBeulich@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Sorry about late reply.

No I haven't planned to do it soon. Your board is supported by mxser driver (drivers/tty/mxser.c).
I think it would be nice to move everything from mxser.c to 8250_moxa.c.

The problem is mxser supports ISA and PCI boards and I don't have the hardware to test it.

Mathieu
