From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Mon, 20 Jan 2014 23:35:41 +0000
Message-ID: <20140120233541.593d0918@www.etchedpixels.co.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
	<1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
	<CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
	<20140120214305.54f65ffa@www.etchedpixels.co.uk>
	<20140120231457.GZ17314@sirena.org.uk>
	<20140120232141.GM15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140120232141.GM15937@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Tushar Behera <tushar.behera@linaro.org>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

> The first bit is easy... but we need to add locks to every serial
> driver to prevent two probes operating concurrently...

The bus probe should already be serializing surely ?

 
