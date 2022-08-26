Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E4ECAAD2
	for <linux-serial@archiver.kernel.org>; Fri, 26 Aug 2022 08:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiHZI1f (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Aug 2022 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbiHZI1c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Aug 2022 04:27:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4574D4F4B;
        Fri, 26 Aug 2022 01:27:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id io24so1018723plb.1;
        Fri, 26 Aug 2022 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cgUSP6ELoUvE2Z57eFANZDctRag6wTGBGhvkczLHT34=;
        b=a/LohNR4/MmbiXxRd34+oT8saeEfimjsNZz3Cmux4NW0yck8WK2wC4KLwBPGeV8kIi
         Zyeg1TF70Wv6GvlgbETH6mBwozYzQMCJoRtp9jJnzl/oRXbxW4XHOzZZ5phPj+cMrWMn
         E1+ju+wXI4lPJO09URjLRpdrUvrTZ1i5cD9cJY0s0ikcnVdr6IbATQVc4PF2Ui0WHEIh
         VgUQaWY44SqgOwziKqnu3DovGcPPWVfqyOJQ8oQHJW8guzk2boKS9QWI6ONuInaevxfV
         tgqJjKo8fvkCYxpL29kNXmWYx+c88J53IeeguQbBFAoduqRxgLKeY+YBuVgbGTMGwSLD
         ToCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cgUSP6ELoUvE2Z57eFANZDctRag6wTGBGhvkczLHT34=;
        b=lQWZqIqdTeTAzEQ4aIc/xgGpSP3uRpqUCgCqvhyyRuFAJ0m8/1UWu9vEXRIRs2fkdD
         KMJ4V3ljFbPchefgHRc6WJwjst9lKw1n81Xr5QcBXKx36Zr3FTXXZABcljVQWG6F8qG9
         9LCaIH6hIFzpptjqDBQk6r2OU65A/LdB9p2nDE+3rekQbcG/tAqxpV+pVOgZXlurKbK9
         mJCZ/c5PULBr6pSl7+cQWKjCF9qvXALOILN49VELNz0Fq5pGDfg+fptXo4wt4cGqsvDS
         S7dqd4YiSyXL0vfAQ2SRQelwmMaWTULkxZLJfc68f0hni/HzLVdGm6yacxA1h/oot/sQ
         Ur3g==
X-Gm-Message-State: ACgBeo2Dvxf4gOjnTGfigM5wW3RFos49SNTsBdNS+Mxg90Ww136JTidB
        wzdM5JbcNZqRhtVqR2QLsgFfYj8fsWAjLezqLLOnHFgTufc=
X-Google-Smtp-Source: AA6agR6fC6l2HwsEZ+7szMEW1TcdD3hlATHldOZLJDZDGpAr8IW0oPvxbA4oemiYvCoQOdo61YnCgy2HSNj2zTjCEME=
X-Received: by 2002:a17:90b:3d91:b0:1fb:49ed:a5c3 with SMTP id
 pq17-20020a17090b3d9100b001fb49eda5c3mr3176093pjb.187.1661502450312; Fri, 26
 Aug 2022 01:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220823055739.1451419-1-floridsleeves@gmail.com> <YwRxwr2J9ba/Agio@kroah.com>
In-Reply-To: <YwRxwr2J9ba/Agio@kroah.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Fri, 26 Aug 2022 01:27:19 -0700
Message-ID: <CAMEuxRpKqHHfT2J-6V1JqyWSMqS4uwCNiLMFLEoYkfpuTM8TuQ@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/tty/serial: check the return value of uart_port_check()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 22, 2022 at 11:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 22, 2022 at 10:57:39PM -0700, lily wrote:
> > uart_port_check() can return NULL pointer.
>
> It can?  How will that happen?
>
When state->uart_port is NULL, uart_port_check() will return a NULL pointer.
This actually is checked in other places like
drivers/tty/serial/serial_core.c:762.
> > Check its return value before dereference it.
>
> How do you trigger this issue, and how was this change you made tested?
>
I detect this issue with a static analysis tool, therefore not dynamically
triggered.
> thanks,
>
> greg k-h
