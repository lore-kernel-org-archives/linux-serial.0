Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EC6EB64DA
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jul 2023 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGDNUP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jul 2023 09:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGDNUK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jul 2023 09:20:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B710F2
        for <linux-serial@vger.kernel.org>; Tue,  4 Jul 2023 06:19:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so47387715e9.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Jul 2023 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688476793; x=1691068793;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvCh8V/rBthoWkYpCH26tqBrzJhbH+Fg29AhlWEeeCs=;
        b=wCOweyhmg4pD8QTF8xhWJp7yhm3+rDqYvhpEWYrpTHmvbm/88sUMloED48lBCY82KO
         sJyUL4/oZXmRd96CIRy8bkZoWV2pstNgK6dtGE03fk/fa1vd71OES/Iht2RJPIcJE4JQ
         F6/DDjki1/le6HdZvHV9KORH3xAw+kgzyGjFAw/M0a/fcoA9Gl4XGSClZ2lEX497Vlue
         MfbOiiwSyKfE7e1TVjcpNcJ0+PI4RTa0D5j3Kj6WmlXL/wQxmOl/vwPnKNkXXoh+y8Zy
         pCSXyWkF8+Cn0TFqwb6H7dBS7TnQ1jyeqPPHxqA30Dn03lTRdTtjSjMB4Q+Ql7GVuvFN
         ZC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688476793; x=1691068793;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvCh8V/rBthoWkYpCH26tqBrzJhbH+Fg29AhlWEeeCs=;
        b=jlHfrhlD7j0k0GJ4ODI2L5kIzdUys+lRF2v8MWi13bpPS2wcwfZnDRbVSoFnC9Oven
         Lgv+G5sEpzKkmjJDYcpijgS4ADFOScgXvIKse6JKc4Eijx7xtT92QdYnx5RwJSvV6bXg
         8QiF3eYx8+xNFIfrBcUoyXWmYozJMVqdvPz9gjpAJ9U6SE/opmAkSc1TDDm9k8oMjCWa
         bbjVhAPOYz6rbQ219CUTUgLhf1U+AY8ozn13Tw19uiY6JSE4GAkRyh49HmvqhbcCK4m0
         iVIFx31vg0E4oeRl3kyG3nlNauq/ynVFgFNn+NOuFs7IhvYhWjGOgat3ZDvgtKW/MyEI
         qh4g==
X-Gm-Message-State: ABy/qLbYFp99S9GQNE2ts9Snl7sdBTaxzHeNQQ3ugkQL2IXDwjUrMqG9
        ZOAR47NVdNJM6/Lb4+4+50CwMw==
X-Google-Smtp-Source: APBJJlFOLi1JViyuQViCj9xygmOZbnGuzgqIAGAYhRgaiXblxn6Q8rQJnCmolFcKSgqpmsa9mlVOIg==
X-Received: by 2002:a05:600c:220c:b0:3fb:a100:2581 with SMTP id z12-20020a05600c220c00b003fba1002581mr8333362wml.14.1688476793162;
        Tue, 04 Jul 2023 06:19:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b0031438257aa9sm4966607wrm.36.2023.07.04.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 06:19:51 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:19:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     biju.das.jz@bp.renesas.com
Cc:     linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [bug report] tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support
Message-ID: <427f194e-d8b6-41de-a1f9-6bec4a9ef057@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Biju Das,

The patch 8749061be196: "tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx
support" from Apr 12, 2023, leads to the following Smatch static
checker warning:

	drivers/tty/serial/sh-sci.c:593 sci_start_tx()
	warn: sleeping in atomic context

drivers/tty/serial/sh-sci.c
    573 static void sci_start_tx(struct uart_port *port)
    574 {
    575         struct sci_port *s = to_sci_port(port);
    576         unsigned short ctrl;
    577 
    578 #ifdef CONFIG_SERIAL_SH_SCI_DMA
    579         if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
    580                 u16 new, scr = serial_port_in(port, SCSCR);
    581                 if (s->chan_tx)
    582                         new = scr | SCSCR_TDRQE;
    583                 else
    584                         new = scr & ~SCSCR_TDRQE;
    585                 if (new != scr)
    586                         serial_port_out(port, SCSCR, new);
    587         }
    588 
    589         if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
    590             dma_submit_error(s->cookie_tx)) {
    591                 if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
    592                         /* Switch irq from SCIF to DMA */
--> 593                         disable_irq(s->irqs[SCIx_TXI_IRQ]);

disable_irq() is a might_sleep() function so it can't be called while
holding a spinlock, but the sci_dma_tx_work_fn() function is holding a
spinlock when it calls sci_start_tx().

    594 
    595                 s->cookie_tx = 0;
    596                 schedule_work(&s->work_tx);
    597         }
    598 #endif


regards,
dan carpenter
