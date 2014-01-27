From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Mon, 27 Jan 2014 10:07:41 +0000
Message-ID: <20140127100741.1fc1608c@www.etchedpixels.co.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
	<1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
	<CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
	<20140120214305.54f65ffa@www.etchedpixels.co.uk>
	<20140120231457.GZ17314@sirena.org.uk>
	<20140120234734.11b78578@www.etchedpixels.co.uk>
	<20140121001657.GO15937@n2100.arm.linux.org.uk>
	<50b66ac6-1150-4ad7-aeaf-3d0dce77334d@email.android.com>
	<20140126115402.GA25689@n2100.arm.linux.org.uk>
	<alpine.LFD.2.11.1401262318350.1652@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1401262318350.1652@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Alan Cox <alan@etchedpixels.co.uk>, Mark Brown <broonie@kernel.org>, Tushar Behera <tushar.behera@linaro.org>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

> Either everything is dynamic, or everything follows proper minor 
> assignment process.

Ultimately everything should probably be dynamic, but trying to get there
in one step will simply mean we never get there at all.

Alan
