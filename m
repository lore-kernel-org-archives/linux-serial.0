Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA9C2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 18:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FC721835
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 18:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lSh6Xeyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAUSfD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:35:03 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15840 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSfC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 13:35:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e27442a0002>; Tue, 21 Jan 2020 10:34:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 Jan 2020 10:35:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 Jan 2020 10:35:01 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jan
 2020 18:35:00 +0000
Subject: Re: [PATCH] serial: 8250_tegra: Create Tegra specific 8250 driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jeff Brasen <jbrasen@nvidia.com>
References: <20200120160149.29072-1-jonathanh@nvidia.com>
 <f02faa4c-5838-15d2-1b76-75c17fcc0d9d@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <714eb00b-bb49-9536-ce9c-8928941edef3@nvidia.com>
Date:   Tue, 21 Jan 2020 18:34:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f02faa4c-5838-15d2-1b76-75c17fcc0d9d@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579631658; bh=G0EhICBZ/7BEBO1885NXBKojV5dMQEqiDzFaZpuvJ+0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lSh6Xeynbe2WGZFmEK52DQGQNq3ePnS9KPflCUxmFWrP3wAukmriI9D8mezv2rUed
         Ap5Omov8OiMR6jiMs4XWY1spLpOwW5W80E8gAVRQFcVJUPLtkU+Mr++zGRpjsRrd2Y
         oPWwHkpqd7phv1UqtFIx48PNEtpAw5MBvkLn9TJA9lWcygePTM5QtcCmjFzcMOgp86
         Y0qA6JnNJx3sGf3enXmV7ZnH0IGvrrg/UwDnTApOwvtijroNVousWxUE4I7cngusHg
         ok27KIBGr5RReOe6+GoDKSM6khr2iHKswVEV6HM6uPRfuIfXKmLu1ZaZZf0xOiDfy6
         +/CuGB1eWl12Q==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 21/01/2020 16:31, Dmitry Osipenko wrote:
> Hello Jon,
>=20
> 20.01.2020 19:01, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
> [snip]
>=20
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENODEV;
>> +
>> +	port->membase =3D devm_ioremap(&pdev->dev, res->start,
>> +				     resource_size(res));
>=20
> devm_platform_ioremap_resource()

That would be ideal, but we cannot. The driver needs the res structure
as well later on.

Jon

--=20
nvpublic
