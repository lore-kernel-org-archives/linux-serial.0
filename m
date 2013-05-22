From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3] tty: serial: add Freescale lpuart driver support
Date: Wed, 22 May 2013 15:23:05 +0800
Message-ID: <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
	<20130520030523.GB25113@S2101-09.ap.freescale.net>
	<13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35799 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab3EVHXI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 May 2013 03:23:08 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so4333452iec.7
        for <linux-serial@vger.kernel.org>; Wed, 22 May 2013 00:23:05 -0700 (PDT)
In-Reply-To: <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jin Zhengxiong-R64188 <R64188@freescale.com>
Cc: Lu Jingchang-B35083 <B35083@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

On 22 May 2013 14:40, Jin Zhengxiong-R64188 <R64188@freescale.com> wrote:
> [Jason Jin-R64188] Reuse the same LPUART on LS-1 with the compatible strings 'fsl,mvf600-lpuart' is technically OK, But it will fuss the route map of the product Line. The general name can show that the IP is shared between several product lines, and the history for which SOC firstly used the IP is not very important. With general compatible name, We can setup the general dts for the shared IPs.
>
> That's also the case for the IPs used on Power platform, Take the IFC for example, this IP implemented on Power platform will also be reused LS-1, The compatible string is set as  "fsl,ifc", "simple-bus" but not the soc name on which the IP first used.
>
>  Another example, though a little different, the nor flash driver, which is used for many platform, the compatible "cfi-flash" will be more reasonable than the soc/board name.
>
> With the general name for the compatible string in the driver, if there is minor difference for the different implementation of the same IP, we can add the soc related compatible string to the driver to pass different .data structure for that soc.
>

As I already said, a generic compatible string does not specify
anything about compatibility/version, and hence it's not a good
compatible for IP block which is possibly to be integrated on multiple
SoCs with slight differences.

For example, if there is a new SoC mvf900 integrating the IP with
everything compatible to the version used on mvf600,

  compatible = <fsl,mvf900-uart>, <fsl,mvf600-uart>;
  compatible = <fsl,mvf900-uart>, <fsl,lpuart>;

which one do you think is better to tell the compatibility/version?

Shawn
