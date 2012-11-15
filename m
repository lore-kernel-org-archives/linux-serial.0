From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
Date: Thu, 15 Nov 2012 09:22:39 +0200
Message-ID: <50A4983F.8080407@bluegiga.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com> <1351074456-25863-3-git-send-email-b32955@freescale.com> <50A21613.6030709@bluegiga.com> <50A45F83.1010009@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:57333 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992753Ab2KOHWl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 02:22:41 -0500
In-Reply-To: <50A45F83.1010009@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, vinod.koul@intel.com, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>, Fabio Estevam <fabio.estevam@freescale.com>

Hi,

On 11/15/2012 05:20 AM, Huang Shijie wrote:
> =E4=BA=8E 2012=E5=B9=B411=E6=9C=8813=E6=97=A5 17:42, Lauri Hintsala =E5=
=86=99=E9=81=93:
>> Hi Huang,
>>
>> DMA support doesn't work with latest stable v3.6.5 or development
>> 3.7-rc5 kernels. I get following error message when I open the seria=
l
>> port /dev/ttyAPP0:
>>
>> [ 48.730000] mxs-auart 8006a000.serial: step 1 error
>> [ 48.750000] mxs-auart 8006a000.serial: We can not start up the DMA.
>>
> I tested this patch set in imx28-evk board Rev C with linux-next-2012=
1114.
> it works fine.
>
> Maybe you can try the linux-next code.

I tested linux-next-20121114 on apx4devkit (imx28 based device) and I=20
got the same error message:

# stty -F /dev/ttyAPP0 crtscts; microcom /dev/ttyAPP0 -s 115200
[  133.710000] mxs-auart 8006a000.serial: step 1 error
[  133.720000] mxs-auart 8006a000.serial: We can not start up the DMA.


> About the flow control:
> If we do not enable the HW flow control, the data may lost. And I do =
not
> know how to handle with the Xon/Xoff when the DMA is supported.

I do not have the answer but it is already implemented in Freescale's=20
reference kernel=20
(http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drive=
rs/serial/mxs-auart.c?h=3Dimx_2.6.35_11.09.01).=20
So I think it is possible to handle all data without HW flow control.


Best Regards,
Lauri Hintsala
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
