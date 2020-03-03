Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7EAC3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 20:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DF820842
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 20:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Tlbxpxb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgCCU5t (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:57:49 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:58545 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgCCU5t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 15:57:49 -0500
Received: from [IPv6:2a03:2260:3009:300:402e:ee34:440:98b9] (unknown [IPv6:2a03:2260:3009:300:402e:ee34:440:98b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9D9C8231D9;
        Tue,  3 Mar 2020 21:57:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583269066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PtQAp1jd9bV2ryiqqYe14ChtIVkk/SPZAu261A3lfB8=;
        b=Tlbxpxb2wPtvw/8v3cyp4HREFGsBcixG0xBHoPu9M0emxm/F2EnXALLqn2NyF2dhf8Ue4X
        M+y7zm4viI68KD2kplXWo98NwYd11nyaoA4iB135C7ALIUCslb2E9OrglPclYZzsZw+phE
        QbHIebUEgOk+/TUoxoLfK6zHc+iRArk=
Date:   Tue, 03 Mar 2020 21:57:42 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20200303184737.GD26191@bogus>
References: <20200303174306.6015-1-michael@walle.cc> <20200303174306.6015-4-michael@walle.cc> <20200303184737.GD26191@bogus>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/9] tty: serial: fsl_lpuart: handle EPROBE_DEFER for DMA
To:     Rob Herring <robh@kernel.org>
CC:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>
From:   Michael Walle <michael@walle.cc>
Message-ID: <8DA9ACF0-755C-4AA7-A292-C00FA025B30B@walle.cc>
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 9D9C8231D9
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[13];
         NEURAL_HAM(-0.00)[-0.511];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:201701, ipnet:2a03:2260:3000::/36, country:DE];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 3=2E M=C3=A4rz 2020 19:47:37 MEZ schrieb Rob Herring <robh@kernel=2Eorg>=
:
>On Tue, Mar 03, 2020 at 06:43:00PM +0100, Michael Walle wrote:
>> The DMA channel might not be available at probe time=2E This is esp=2E
>the
>> case if the DMA controller has an IOMMU mapping=2E
>
>The subject should be updated as this doesn't involve deferred probe
>any more=2E=20

ok

>
>> There is also another caveat=2E If there is no DMA controller at all,
>> dma_request_chan() will also return -EPROBE_DEFER=2E Thus we cannot
>test
>> for -EPROBE_DEFER in probe()=2E Otherwise the lpuart driver will fail
>to
>> probe if, for example, the DMA driver is not enabled in the kernel
>> configuration=2E
>>=20
>> To workaround this, we request the DMA channel in _startup()=2E Other
>> serial drivers do it the same way=2E
>>=20
>> Signed-off-by: Michael Walle <michael@walle=2Ecc>
>> ---
>>  drivers/tty/serial/fsl_lpuart=2Ec | 84
>+++++++++++++++++++++------------
>>  1 file changed, 53 insertions(+), 31 deletions(-)
>>=20
>> diff --git a/drivers/tty/serial/fsl_lpuart=2Ec
>b/drivers/tty/serial/fsl_lpuart=2Ec
>> index c31b8f3db6bf=2E=2E0b8c477b32a3 100644
>> --- a/drivers/tty/serial/fsl_lpuart=2Ec
>> +++ b/drivers/tty/serial/fsl_lpuart=2Ec
>> @@ -1493,36 +1493,63 @@ static void rx_dma_timer_init(struct
>lpuart_port *sport)
>>  static void lpuart_tx_dma_startup(struct lpuart_port *sport)
>>  {
>>  	u32 uartbaud;
>> +	int ret;
>> =20
>> -	if (sport->dma_tx_chan && !lpuart_dma_tx_request(&sport->port)) {
>> -		init_waitqueue_head(&sport->dma_wait);
>> -		sport->lpuart_dma_tx_use =3D true;
>> -		if (lpuart_is_32(sport)) {
>> -			uartbaud =3D lpuart32_read(&sport->port, UARTBAUD);
>> -			lpuart32_write(&sport->port,
>> -				       uartbaud | UARTBAUD_TDMAE, UARTBAUD);
>> -		} else {
>> -			writeb(readb(sport->port=2Emembase + UARTCR5) |
>> -				UARTCR5_TDMAS, sport->port=2Emembase + UARTCR5);
>> -		}
>> +	sport->dma_tx_chan =3D dma_request_slave_channel(sport->port=2Edev,
>"tx");
>> +	if (!sport->dma_tx_chan) {
>> +		dev_info_once(sport->port=2Edev,
>> +			      "DMA tx channel request failed, operating without tx
>DMA\n");
>
>Might be useful to print the errno too=2E

I didn't want to change the original error message=2E But I can change tha=
t when I update the subject=2E=20

-michael

