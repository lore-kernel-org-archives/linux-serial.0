Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B43C4743C
	for <linux-serial@archiver.kernel.org>; Wed, 23 Jun 2021 05:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCD261351
	for <linux-serial@archiver.kernel.org>; Wed, 23 Jun 2021 05:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWFjQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Jun 2021 01:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWFjQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Jun 2021 01:39:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96999C061574;
        Tue, 22 Jun 2021 22:36:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x16so1396256pfa.13;
        Tue, 22 Jun 2021 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AQRbdvlEzNewyBiB8GAbtjoKUhD1w7YQa/iIzknp8dg=;
        b=TK8MdnwzQ/Jk+D6q+zWpiZw9dHGWKB8f7r2aue6rplscVRIZ0Hhu0h86bRh4GDxXCi
         Q0xb2tuyY2C69bpvnxPdKAG24rlCB9s+8cKOv7lM/tl1rwtcui8OqD8XD7L/3VqGhP4e
         eUWOgJDvya/60v42+AhWwrl9V37eWYrVihwnZb/e6umLHAseeKqhb8vfz4TffxgdSjgA
         KLr4AMMVZmYlfpxpPgnJQB21jlFubHxReoTwW97XhiK54m8JAZpcY8wv9H+yZrIzJKs4
         9ordQsFZBizoIczQ+lqbaULrmGtSDgNmj4mNpZhOf0tZhpaKkU6XN4erunyQ2JDNYA71
         5eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQRbdvlEzNewyBiB8GAbtjoKUhD1w7YQa/iIzknp8dg=;
        b=UiWFqkUDJuvjY4T34OrHkIDrCWV2np63BPW5Xc35fLIgaraNFxmu2TYVgPmd95XuUl
         DjVQAiVLAI8yPXtrinRgjki8PPPsPGWQsr7KIosBZ6C8O6CF3rF7DnS0VVPd+cQJId0H
         wCWEfEI4p5vEAk8+/nhaPIlCGTQXBFKOySG0MyZhWGTsxbViXdq5S5xCrFdH80whI30B
         JGM1juPkCyTbO42DsSV5T3aWvv+u9NJ8LZm1e0BGaegJurUA4VntTQDzvyLvJe5q9qLb
         Er8aLabHlNJqlARHGT8AIKnuXhwvajhHk25JMtut9LnrUEdXvs6ZbwYecT/zxPtqI+/P
         DplQ==
X-Gm-Message-State: AOAM531zAwusaI5YLOGwSNb3HxKfQJBxBa9SXfvP3if+yOIkJcm5ExAl
        ltF+ZQMDI+G0XySHnFOWFjc=
X-Google-Smtp-Source: ABdhPJxK/OTlaQ5fxxbccCy+u+iWXDIo4/zFpY2Kq+fUAVFKmhsjtui7R9S8DLetiHJHde9mIEgXtA==
X-Received: by 2002:a05:6a00:14d2:b029:2ec:e968:b11b with SMTP id w18-20020a056a0014d2b02902ece968b11bmr7192767pfu.43.1624426619022;
        Tue, 22 Jun 2021 22:36:59 -0700 (PDT)
Received: from [192.168.0.118] ([103.242.196.10])
        by smtp.gmail.com with ESMTPSA id 188sm1017355pfx.127.2021.06.22.22.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 22:36:58 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: owl: Fix data race in owl_uart_remove
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
References: <20210617110443.6526-1-saubhik.mukherjee@gmail.com>
 <YMswdqNpjb9n1pdW@kroah.com>
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Message-ID: <ceebf511-9971-6deb-a6dd-458d69de2bbd@gmail.com>
Date:   Wed, 23 Jun 2021 11:06:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMswdqNpjb9n1pdW@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 6/17/21 4:52 PM, Greg KH wrote:
> On Thu, Jun 17, 2021 at 04:34:43PM +0530, Saubhik Mukherjee wrote:
>> Suppose the driver is registered and a UART port is added. Once an
>> application opens the port, owl_uart_startup is called which registers
>> the interrupt handler owl_uart_irq.
>>
>> We could have the following race condition:
>>
>> When device is removed, owl_uart_remove is called, which calls
>> uart_remove_one_port, which calls owl_uart_release_port, which writes
>> NULL to port->membase. At this point parallely, an interrupt could be
>> handled by owl_uart_irq which reads port->membase.
>>
>> This is because it is possible to remove device without closing a port.
>> Thus, we need to check it and call owl_uart_shutdown in owl_uart_remove.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
>> ---
>>   drivers/tty/serial/owl-uart.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
>> index 91f1eb0058d7..ac4e3aae2719 100644
>> --- a/drivers/tty/serial/owl-uart.c
>> +++ b/drivers/tty/serial/owl-uart.c
>> @@ -751,8 +751,15 @@ static int owl_uart_probe(struct platform_device *pdev)
>>   static int owl_uart_remove(struct platform_device *pdev)
>>   {
>>   	struct owl_uart_port *owl_port = platform_get_drvdata(pdev);
>> +	struct uart_port *port = &owl_port->port;
>>   
>> -	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
>> +	/* It is possible to release device without closing a port.
>> +	 * Thus, need to check it and call shutdown.
>> +	 */
>> +	if (owl_uart_read(port, OWL_UART_CTL) & OWL_UART_CTL_EN)
>> +		owl_uart_shutdown(port);
> 
> How is this read determining if the device is here or not?  And what
> happens if the state change happens right _after_ the check?
> 
> Also, your comment style is for networking, not the rest of the kernel
> :)
Thank you for your comments. OWL_UART_CTL_EN is set during startup and 
cleared during shutdown. It is not used anywhere else. So, it is used to 
determine if the port is opened.

To avoid issue due to state change right after check, the patch is 
updated. A global mutex is used to avoid race between owl_uart_startup 
and owl_uart_remove. The port opened check is done inside owl_uart_shutdown.

Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
---
  drivers/tty/serial/owl-uart.c | 27 ++++++++++++++++++++++-----
  1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 91f1eb0058d7..7a17f4637ea2 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -68,6 +68,8 @@

  static struct uart_driver owl_uart_driver;

+static DEFINE_MUTEX(owl_uart_mutex);  /* race between startup & remove */
+
  struct owl_uart_info {
  	unsigned int tx_fifosize;
  };
@@ -283,13 +285,19 @@ static void owl_uart_shutdown(struct uart_port *port)
  	spin_lock_irqsave(&port->lock, flags);

  	val = owl_uart_read(port, OWL_UART_CTL);
-	val &= ~(OWL_UART_CTL_TXIE | OWL_UART_CTL_RXIE
-		| OWL_UART_CTL_TXDE | OWL_UART_CTL_RXDE | OWL_UART_CTL_EN);
-	owl_uart_write(port, val, OWL_UART_CTL);

-	spin_unlock_irqrestore(&port->lock, flags);
+	/* Check if port is opened */
+	if (val & OWL_UART_CTL_EN) {
+		val &= ~(OWL_UART_CTL_TXIE | OWL_UART_CTL_RXIE
+			| OWL_UART_CTL_TXDE | OWL_UART_CTL_RXDE | OWL_UART_CTL_EN);
+		owl_uart_write(port, val, OWL_UART_CTL);
+
+		spin_unlock_irqrestore(&port->lock, flags);

-	free_irq(port->irq, port);
+		free_irq(port->irq, port);
+	} else {
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
  }

  static int owl_uart_startup(struct uart_port *port)
@@ -298,6 +306,8 @@ static int owl_uart_startup(struct uart_port *port)
  	unsigned long flags;
  	int ret;

+	mutex_lock(&owl_uart_mutex);
+
  	ret = request_irq(port->irq, owl_uart_irq, IRQF_TRIGGER_HIGH,
  			"owl-uart", port);
  	if (ret)
@@ -317,6 +327,7 @@ static int owl_uart_startup(struct uart_port *port)

  	spin_unlock_irqrestore(&port->lock, flags);

+	mutex_unlock(&owl_uart_mutex);
  	return 0;
  }

@@ -752,10 +763,16 @@ static int owl_uart_remove(struct platform_device 
*pdev)
  {
  	struct owl_uart_port *owl_port = platform_get_drvdata(pdev);

+	mutex_lock(&owl_uart_mutex);
+
+	/* Avoid removing port without closing */
+	owl_uart_shutdown(&owl_port->port);
+
  	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
  	owl_uart_ports[pdev->id] = NULL;
  	clk_disable_unprepare(owl_port->clk);

+	mutex_unlock(&owl_uart_mutex);
  	return 0;
  }

-- 
2.30.2
