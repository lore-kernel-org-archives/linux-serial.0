Return-Path: <SRS0=UUkf=D3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3790C433E7
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 13:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552B5224B8
	for <linux-serial@archiver.kernel.org>; Tue, 20 Oct 2020 13:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4l4GEUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407241AbgJTNHT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406825AbgJTNHS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Oct 2020 09:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603199237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type;
        bh=2anAzapiudNNR8XpuCb8etqjbkocHf/cArg3i1fKpjA=;
        b=G4l4GEUngMtccYXYpLvjP5OJN44Qo+j70S8nfm5SXCd/pCQzPC0pewJetP6U3q6K3xbG2Q
        M4Cn13OK0U2UBzrK3Dk9Le6luMsjzzfQgK59lhVJ0rHdohORzUlzlHxomdIM/wU/TQRgUA
        /Qg5DCX5tZE2W4kmroRB27lWtd7nt+w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-MP1dPxyeOcqPI3RYv2Rvow-1; Tue, 20 Oct 2020 09:07:15 -0400
X-MC-Unique: MP1dPxyeOcqPI3RYv2Rvow-1
Received: by mail-qv1-f72.google.com with SMTP id x34so1279101qvx.7
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2020 06:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2anAzapiudNNR8XpuCb8etqjbkocHf/cArg3i1fKpjA=;
        b=TIxj4qGY1yPDqG0/uNMltysvTBXdabPXMPoSUmvYESk7w/43H/dlDAomLe8ruDLNvM
         ch1jNo6GZSRpueyx7wv8yo9GXS9JRyFMfcuFvbXJMm707Bo+2HtnMv0Lw6tDkojNVrXV
         wh6AhUkurMONBZMfFWLxwDjpYnr79p7bAVYQvzpPSBnUuRVtDdIut4eke6PkWyHp5inP
         aRbsYhmfGXcTy38yGlyodBtIBkjb6Kyy0FnRtdhTaPIbTEZEqaikFimzIVZ6xwD6oNh/
         jxgsLFtpU9eBnb9jZMErCLHOxiVOPzyIK0Ms2BV4UEvac1jdCNuAMuQvblklHBVe3WXm
         bjug==
X-Gm-Message-State: AOAM530LladV2X7AX9/mjpA+LvhuhpzXH0k6y5BZ+ZtyrQQ7L5a1ansK
        eFOb7wgttyrwtOVuQWaJjNHXPTF1zZ9xw1JiSzpGYY1DRFeMffc9e+JiIwkpNfF+Ej2glaHFSsy
        BPijSVZgNNd4SoGzLt+FNNMZS
X-Received: by 2002:aed:216b:: with SMTP id 98mr2299339qtc.233.1603199234933;
        Tue, 20 Oct 2020 06:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqNg7p1DO3AxkYDn6Hv+sy3YgDE6VecvNiBWMxgWFr77Yf6Q7cXLbaArbHxGEA5CBuDcGZyg==
X-Received: by 2002:aed:216b:: with SMTP id 98mr2299314qtc.233.1603199234669;
        Tue, 20 Oct 2020 06:07:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 8sm760540qkm.0.2020.10.20.06.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:07:14 -0700 (PDT)
From:   trix@redhat.com
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] tty: serial: imx: remove unneeded break
Date:   Tue, 20 Oct 2020 06:07:09 -0700
Message-Id: <20201020130709.28096-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---

v2: improve commit log

---
 drivers/tty/serial/imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1731d9728865..09703079db7b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -320,7 +320,6 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 	switch (offset) {
 	case UCR1:
 		return sport->ucr1;
-		break;
 	case UCR2:
 		/*
 		 * UCR2_SRST is the only bit in the cached registers that might
@@ -331,16 +330,12 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 		if (!(sport->ucr2 & UCR2_SRST))
 			sport->ucr2 = readl(sport->port.membase + offset);
 		return sport->ucr2;
-		break;
 	case UCR3:
 		return sport->ucr3;
-		break;
 	case UCR4:
 		return sport->ucr4;
-		break;
 	case UFCR:
 		return sport->ufcr;
-		break;
 	default:
 		return readl(sport->port.membase + offset);
 	}
-- 
2.18.1

