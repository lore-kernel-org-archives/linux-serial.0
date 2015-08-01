From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: etraxfs-uart: use mctrl_gpio helpers for
 handling modem signals
Date: Sat, 1 Aug 2015 08:00:18 -0700
Message-ID: <20150801150018.GA688@roeck-us.net>
References: <1437782566-11528-1-git-send-email-nks@flawful.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437782566-11528-1-git-send-email-nks@flawful.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <nks@flawful.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, Jul 25, 2015 at 02:02:46AM +0200, Niklas Cassel wrote:
> In order to use the mctrl_gpio helpers, we change the DT bindings:
> ri-gpios renamed to rng-gpios. cd-gpios renamed to dcd-gpios.
> However, no in-tree dts/dtsi specifies these, so no worries.
> 
> Signed-off-by: Niklas Cassel <nks@flawful.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

Any chance to get this into -next ? The problem it fixes
still causes my crisv32 qemu tests to fail.
