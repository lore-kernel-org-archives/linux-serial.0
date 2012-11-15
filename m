From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
Date: Thu, 15 Nov 2012 11:20:35 +0800
Message-ID: <50A45F83.1010009@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com> <1351074456-25863-3-git-send-email-b32955@freescale.com> <50A21613.6030709@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:17492
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423500Ab2KODQm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 22:16:42 -0500
In-Reply-To: <50A21613.6030709@bluegiga.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, vinod.koul@intel.com, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>

=E4=BA=8E 2012=E5=B9=B411=E6=9C=8813=E6=97=A5 17:42, Lauri Hintsala =E5=
=86=99=E9=81=93:
> Hi Huang,
>
> DMA support doesn't work with latest stable v3.6.5 or development=20
> 3.7-rc5 kernels. I get following error message when I open the serial=
=20
> port /dev/ttyAPP0:
>
> [ 48.730000] mxs-auart 8006a000.serial: step 1 error
> [ 48.750000] mxs-auart 8006a000.serial: We can not start up the DMA.
>
I tested this patch set in imx28-evk board Rev C with linux-next-201211=
14.
it works fine.

Maybe you can try the linux-next code.

About the flow control:
If we do not enable the HW flow control, the data may lost. And I do no=
t=20
know how to handle with the Xon/Xoff when the DMA is supported.

Best Regards
Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
