Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BEFC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447FF60F25
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 17:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhJURkM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJURkM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Oct 2021 13:40:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF9C061764
        for <linux-serial@vger.kernel.org>; Thu, 21 Oct 2021 10:37:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g20so2303389qka.1
        for <linux-serial@vger.kernel.org>; Thu, 21 Oct 2021 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MfMtQZQ55k5ZQzBjHBoh/0E1V9sA4jpD7fnoidCN0w8=;
        b=TFZfdtfxbNPNM2ME5TfKpt48QXg2qWGJRuIH3UhwsR0echWOcR17msdb0XAfooKgQl
         0MNsLg4bmuaPAghK8bd5KRtcEgZlgDK8oyfd7KOAcAwTTK0W0vHd7+nPzgTknKsxvyvK
         d5Z1pYSwFfFLcqcaJARms8WdsjFElWql204CLoIzJrfVy53At3Mr+JdRc04mquK/Wr+0
         ZteYxJGPWNvHNmNWq/3QU1ya0sN1qy00PtQ97k1fWrTpQ5VoyhXH2RgeDWs83xqSDgRS
         HfoyTv4PmeW1pVRi/crchYq092B2oJZHlIXg0s2WaUAsxLWegm7rQp8wzF+hy244PWyg
         iWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MfMtQZQ55k5ZQzBjHBoh/0E1V9sA4jpD7fnoidCN0w8=;
        b=jbxV6ihXAYShRkemmSHRlnix0DuOKBqPDQPbfl3/5Nd6sU+Jf/7JUuE1ecKnO1Ia5p
         2v3W/tdzCm7gJLkQoBtYWUtJT/P8cNfnLYxf7Sg8t1OnnXoFzT89d4ZBCZYWvCf0VVfS
         b+Nb3+h0P6/yRiyhmSG04HmSJzBSmlD06XKp/aLekA0EJG1r/ty0Jd10dnl2NjcS5yC+
         AZ9rDUHtm8loyVAP9WVpeSO8l6glIaUXU9vzSiLtN4WMSBjFOc3VJHtxtlhx/UDrbDCi
         nPOon/TCdUNJ1KO0hv/q/oElZFbmGWZ4q8fFjN3c85KtO08tEl3N8dJ8SsYap09L0j0o
         bXqQ==
X-Gm-Message-State: AOAM5335oWuGTlCFtNO0UZgISZapek/uOIr6AYfVOK9Oe1iXy0KrZSA6
        1UwNIimTfoOVLWk1PMFdua4VAIIVY0vb/MbToPA=
X-Google-Smtp-Source: ABdhPJymGl6mE8toK3S2Ln4e5dqc+7orMuOyx/MQtGrtp0go3+ImVi09cYVQexPJUKpQiD1HTpnKtg==
X-Received: by 2002:a37:a5c1:: with SMTP id o184mr5611024qke.9.1634837874919;
        Thu, 21 Oct 2021 10:37:54 -0700 (PDT)
Received: from SLTS-20200428.int.sealevel.com ([12.18.222.51])
        by smtp.gmail.com with ESMTPSA id e16sm2842579qkl.108.2021.10.21.10.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:37:54 -0700 (PDT)
From:   mrhowel@g.clemson.edu
X-Google-Original-From: matthew.howell@sealevel.com
Date:   Thu, 21 Oct 2021 13:37:48 -0400 (EDT)
X-X-Sender: ts-test@SLTS-20200428.int.sealevel.com
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
cc:     mrhowel@g.clemson.edu,
        Matthew Howell <matthew.howell@sealevel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: Possible issue with RS485 IOCTLs on 16C950 UARTs?
In-Reply-To: <YXF5nig6PzRWsLjS@kroah.com>
Message-ID: <alpine.DEB.2.22.394.2110211309240.10868@SLTS-20200428.int.sealevel.com>
References: <BY5PR05MB7092A78C7C3441240685522DF9BE9@BY5PR05MB7092.namprd05.prod.outlook.com> <YXEdFPyvpnBCeoxt@kroah.com> <alpine.DEB.2.22.394.2110211004030.10664@SLTS-20200428.int.sealevel.com> <YXF5nig6PzRWsLjS@kroah.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Thu, 21 Oct 2021, gregkh@linuxfoundation.org wrote:

> On Thu, Oct 21, 2021 at 10:10:30AM -0400, mrhowel@g.clemson.edu wrote:
> > 
> > That noticed is enforced by our exchange server. I have removed it by 
> > using an external email address instead.
> > 
> > Original message is copied below.
> > 
> > Hi,
> > 
> > I'm not sure if this is the right place for this, but hopefully someone 
> > can help me figure out what else I can do to troubleshoot this problem, or 
> > point me to the right place to ask questions about this.
> > 
> > A recent investigation led us to discover issues related to the RS485 
> > IOCTLs on our serial cards utilizing the 16C950 UART. More specifically, 
> > the TIOCSRS485 IOCTL to set the serial_rs485 flags as documented at 
> > https://www.kernel.org/doc/html/latest/driver-api/serial/serial-rs485.html 
> > .
> > 
> > When attempting to set the SER_RS485_ENABLED flag using TIOCSRS485 as per 
> > below I receive an error code 25, "Inappropriate IOCTL for device"
> > 
> > 	/* -----RS485----- */
> > 	struct serial_rs485 rs485conf = {0};
> > 	rs485conf.flags |= SER_RS485_ENABLED;
> > 	rc = ioctl(fd, TIOCSRS485, &rs485conf);
> > 	if (rc < 0) {
> >         	printf("error=%d %s\n", errno, strerror(errno));
> > 		return rc;
> > 	}
> > 
> > >From what I've read this typically indicates an unsupported serial device, 
> > but the documentation mentions the 16C950 UART as a specific example, so I 
> > would think the kernel is intended to support this functionality on the 
> > 16C950. 
> >  
> > I have tried this across several kernel versions: 3.10 (Centos 7) , 4.18 
> > (Centos 8), and 5.11 (Ubuntu 21.04) with no change in the behavior. 
> > The issue was originally discovered on a PLX OXPCIe952 UART, but has been 
> > replicated on 'standard' OX16C950 UARTs as well. setserial -ag correctly 
> > identifies all cards as 16950's (Specifically "16950/954").
> > 
> > Has anyone else had or seen this IOCTL issue on the 16C950? Are there any 
> > 'known good' 16C950 based cards people can confirm that this works with?
> 
> I do not think that that type of hardware actually supports RS485, as the
> kernel is reporting that the driver says it is not allowed.
>
> Perhaps you need to find some hardware that does support it?  It is not
> very common at all.

I know support for serial_rs485 is not very common, but the documentation 
for serial_rs485 explicitly mentions the 16C950 UART, which is the UART 
used by the serial card under test.

The datasheet for the 16C950 indeed does not mention "RS485 Auto-Enable", 
but it does say that the DTR pin may be programmed to automatically turn 
the transmitter on and off. See "485_EN" on Page 10 and "ACR[4:3]: DTR# 
line configuration" on page 36 of the manual. 
(https://www.semiconductorstore.com/pdf/newsite/oxford/ox16c950b.pdf)

It doesn't use the same terminology, but it is my understanding that the 
functionality of these registers is sufficient for the 16C950 to support 
RS485 Auto-Enable.

Additionally, the Windows driver for this card supports RS485 Auto-Enable.
 
> good luck!
> 
> greg k-h
> 
