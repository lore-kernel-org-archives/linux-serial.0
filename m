Return-Path: <SRS0=VMdU=AA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9393C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 02:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50F02080D
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 02:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh02rwci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgFSC23 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 22:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgFSC22 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 22:28:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658BFC06174E;
        Thu, 18 Jun 2020 19:28:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k2so3447539pjs.2;
        Thu, 18 Jun 2020 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wG8/XQn4KzN0YWyUgx1JpsSAGLw9HIHZ4dGHE5ZdQmM=;
        b=Gh02rwcibGc0vA5mgrQX0JpbVXM8ZkiXGhJW+9kM4RqKjhNypiyrlCyuhD2YzvJj20
         dT7RheOWy7AibQlnx7yfui0w9iGdEMCkMhpTWY+RGeXTXttcSvX5TyuB3LbUVthdohh8
         fUPhUcGCF6rWmoy3VAlzgvmex58kcQn+6W7OjB9/19K/hhaxzA3gXUpTNNbhoYpMp6eR
         gbQ+415RE9Z0EvNLsreZ6nZNFU6H517P2RhlOJvYkimgD7jIoNwhdEImGLI5zPnheUEB
         Zi2lIogaObbIvsuCx2Wz28yFYUoSwrdZxgoWr5ECzdh8TvywYVoR88Tq3UPkJ3+bdysk
         DuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wG8/XQn4KzN0YWyUgx1JpsSAGLw9HIHZ4dGHE5ZdQmM=;
        b=I9IBfDy9gkXQBQUheThmUu3AeUEsfJbf3NaEWsJzUWHz2oJU+NzeYioHsVz4M9Ihpb
         Zn4sjZ3BOLh87lyhNW/6/n+sSGoIEk5UMKV5a7NFXP+iiSE83WRDiKQncy2kGuKClk60
         k1HOfrC8stzZ4Sc+FJIBVEHVB9VLT61juFCOeLRqby6G9NrfPEBk7Gy/3nx4cGh1M4sh
         1WtkEjCqoUVtqXZzfGseWIPcpgJhyo/vsQBy1PeDxwDItOGRQcziWxMw55PmitqT5YJl
         OPOQhjh8mXGNzKXqs1R9M3cCwlJOMt3LCrmDhxOPutDzp5SGyRvJsIlMttlylCZb+xPF
         OhNA==
X-Gm-Message-State: AOAM5313osAkv4NJmK58AzdMrXv2LVwKh9dnyh+lB5vycDLa/M5GbTYk
        jWQGkRSgodhXq5aRXEChVRjG8+yT
X-Google-Smtp-Source: ABdhPJwdXPRPZiH4coYLixfeZXSKZJxxzvPxkPdPElrvS6M0XtCDjF2Ff57XnN4M1GeZMSmSihGKog==
X-Received: by 2002:a17:90b:30d8:: with SMTP id hi24mr1329797pjb.78.1592533706804;
        Thu, 18 Jun 2020 19:28:26 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a12sm4132478pfr.44.2020.06.18.19.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 19:28:25 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 19 Jun 2020 11:28:22 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/6] console: unify return codes from ->setup() hook
Message-ID: <20200619022822.GA310968@jagdpanzerIV.localdomain>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/06/18 19:47), Andy Shevchenko wrote:
> Some of the console providers treat error code, returned by ->setup() hook,
> differently. Here is the unification of the behaviour.
> 
> The drivers checked by one of the below criteria:
> 1/ the driver has explicit struct console .setup assignment
> 2/ the driver has assigned callback to the setup member
> 
> All such drivers were read in order to see if there is any problematic return
> codes, and fixed accordingly which is this series in the result.
> 
> Andy Shevchenko (6):
>   mips: Return proper error code from console ->setup() hook
>   serial: sunsab: Return proper error code from console ->setup() hook
>   serial: sunzilog: Return proper error code from console ->setup() hook
>   tty: hvc: Return proper error code from console ->setup() hook
>   console: Propagate error code from console ->setup()
>   console: Fix trivia typo 'change' -> 'chance'
> 
>  arch/mips/fw/arc/arc_con.c    | 4 +++-
>  drivers/tty/hvc/hvsi.c        | 2 +-
>  drivers/tty/serial/sunsab.c   | 2 +-
>  drivers/tty/serial/sunzilog.c | 2 +-
>  kernel/printk/printk.c        | 8 ++++----
>  5 files changed, 10 insertions(+), 8 deletions(-)

Looks good to me. I'd also, probably, unify the naming. I can grep
71 foo_console_setup() and only 1 foo_setup_console().

---
 drivers/tty/hvc/hvc_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 5ef08905fe05..2a0e51a20e34 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -603,7 +603,7 @@ static void xen_hvm_early_write(uint32_t vtermno, const char *str, int len) { }
 #endif
 
 #ifdef CONFIG_EARLY_PRINTK
-static int __init xenboot_setup_console(struct console *console, char *string)
+static int __init xenboot_console_setup(struct console *console, char *string)
 {
 	static struct xencons_info xenboot;
 
@@ -647,7 +647,7 @@ static void xenboot_write_console(struct console *console, const char *string,
 struct console xenboot_console = {
 	.name		= "xenboot",
 	.write		= xenboot_write_console,
-	.setup		= xenboot_setup_console,
+	.setup		= xenboot_console_setup,
 	.flags		= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
 	.index		= -1,
 };
-- 
2.27.0
