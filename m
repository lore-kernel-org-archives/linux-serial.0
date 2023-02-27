Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F2C64ED8
	for <linux-serial@archiver.kernel.org>; Mon, 27 Feb 2023 07:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjB0HQi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Feb 2023 02:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HQh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Feb 2023 02:16:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6923A1C307
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 23:16:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v16so2278918wrn.0
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 23:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJr9uKOfN/wZLR1mjPtbvwdEWkA72spRbsMlk4YNxoc=;
        b=YBlYK6qW9MwoEOWCrgLEV7YcFEF5tO/uQm7XRA0CFwj94VyDfmycfJaHrVOj4Oo7Oa
         zVkBu1lbgJWBI1Iz+Ds6FCONMK38S6KnSmufyCPEcUiA3RVPC6lQGBy2g27BHNAdLR1j
         1YLqTy8OBV658ALBVue/oVEfqZ+B5tB1sQHfZrzOgNVjbRbOfoOf8v+BLGuoquZsQ4tS
         ipP1yjgysSb8JOP7HKQHCrx+R5J0BsjKdyJxCctKZ5jGVZ5IpR92h+up341gRS5SqH8S
         K02n+N2/sHSIZQyaYzNNY+wEv+Lirc9QRCUy73kO6CqZ3Vm0ji1beHMIUXS00rlIUXdc
         2+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJr9uKOfN/wZLR1mjPtbvwdEWkA72spRbsMlk4YNxoc=;
        b=UKyhKRKdIroDLmf2+bcJwq3rgAQEJ7UIBeiE5r0c4SnwaT8qKpsfYXvyEbo5iqTOVT
         1FqipmSc/oVzDeYxEX2io+qSPm9qSNaQDsNgrHd4dUcR4KkxZhVSnsD9nTM3Zv46XkPC
         ev9tKv+sxRyRaON7/yHFZ1AwznhPEpbQZiyGH5wGSqZFj15YM69cUGUk5ZzkQ+bTy/LZ
         2ocgwVvPxtkAUlCBDcDodQEcWi2q4aNc1bRAutzvbe8A+8UkVajM978Y2ZFLur0IK1J6
         1UQEZrzs8HYouE5TfLQpHBXqEabVmGBZkhwAvTEPJTEXzr5YqscAd7qTuDKmWV2y3lv7
         2ymQ==
X-Gm-Message-State: AO0yUKVKojwVgoOafYDcLcGM2j4t8KjO19ze/oiG2t3NQDgdnrVHqMPL
        HuGhhzeP0axGVFNjpuFBMUA=
X-Google-Smtp-Source: AK7set8QOFzabs6Yyabd3YcaZf9jPc3ekN2vqrecFRH/2T4klLHidHjta2W5EiGmTeKXhiaoHO22+A==
X-Received: by 2002:a5d:58d9:0:b0:2c5:5fb0:b215 with SMTP id o25-20020a5d58d9000000b002c55fb0b215mr19399072wrf.30.1677482194747;
        Sun, 26 Feb 2023 23:16:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f7-20020adffcc7000000b002c7163660a9sm6381416wrs.105.2023.02.26.23.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 23:16:34 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:16:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     johan@kernel.org
Cc:     linux-serial@vger.kernel.org
Subject: [bug report] serial: 8250: fix handle_irq locking
Message-ID: <Y/xYzqp4ogmOF5t0@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Johan Hovold,

The patch 853a9ae29e97: "serial: 8250: fix handle_irq locking" from
Jul 14, 2021, leads to the following Smatch static checker warning:

drivers/tty/serial/8250/8250_fsl.c:84 fsl8250_handle_irq() warn: inconsistent returns 'flags'.
  Locked on  : 38,46
  Unlocked on: 84

drivers/tty/serial/8250/8250_fsl.c
    26  int fsl8250_handle_irq(struct uart_port *port)
    27  {
    28          unsigned long flags;
    29          u16 lsr, orig_lsr;
    30          unsigned int iir;
    31          struct uart_8250_port *up = up_to_u8250p(port);
    32  
    33          spin_lock_irqsave(&up->port.lock, flags);
                                                  ^^^^^
    34  
    35          iir = port->serial_in(port, UART_IIR);
    36          if (iir & UART_IIR_NO_INT) {
    37                  spin_unlock(&up->port.lock);
    38                  return 0;

Needs to enable IRQs again.  Same below etc.

    39          }
    40  
    41          /* This is the WAR; if last event was BRK, then read and return */
    42          if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
    43                  up->lsr_saved_flags &= ~UART_LSR_BI;
    44                  port->serial_in(port, UART_RX);
    45                  spin_unlock(&up->port.lock);
    46                  return 1;
    47          }
    48  

regards,
dan carpenter
