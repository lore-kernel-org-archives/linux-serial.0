From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
Date: Mon, 5 Nov 2012 11:16:53 +0800
Message-ID: <50972FA5.4020605@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>	 <1351074456-25863-3-git-send-email-b32955@freescale.com>	 <1351138689.5263.68.camel@vkoul-udesk3> <5088D336.7040206@freescale.com>	 <1351145272.7077.8.camel@vkoul-udesk3>  <5089033F.9040100@freescale.com> <1351163280.7077.11.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:22561
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752400Ab2KEDNO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Nov 2012 22:13:14 -0500
In-Reply-To: <1351163280.7077.11.camel@vkoul-udesk3>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vinod Koul <vkoul@infradead.org>
Cc: vinod.koul@intel.com, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, lauri.hintsala@bluegiga.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com

=E4=BA=8E 2012=E5=B9=B410=E6=9C=8825=E6=97=A5 19:08, Vinod Koul =E5=86=99=
=E9=81=93:
> On Thu, 2012-10-25 at 17:15 +0800, Huang Shijie wrote:
>> yes. I have to setup the register. Could you told me which API is th=
e
>> right API?
> dmaengine_slave_config() should be used to send the slave specfic
> parameters
It seems hard to set the registers by the

dmaengine_slave_config().

[1] firstly, there are several drivers use the mxs-dma, the gpmi-nand, =
mxs-mmc,spi-mxs, i2c-mxs.
        If we set the registers by the dmaengine_slave_config(), we mus=
t have the register base address for gpmi, mxs, spi, i2c.
      It's not a good idea to access these registers in the mxs-dma dri=
ver.

[2] secondly, take gpmi_read_page() for example, it uses the DMA_TRANS_=
NONE several times :
     If we set the registers by the dmaengine_slave_config(), the gpmi_=
read_page() will become like:
     .....................................
     dmaengine_slave_config()
     dmaengine_prep_slave_sg().
     ...................................

     dmaengine_slave_config()
     dmaengine_prep_slave_sg().
     ...................................

      dmaengine_slave_config()
      dmaengine_prep_slave_sg().
     ...................................

     Is it a nice look?

  [3] dma_slave_config{} does not have the fields to contain the regist=
ers value.


So I think the  current code it's ok, we'd better do not change it.

thanks
Huang Shijie










--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
