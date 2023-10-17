Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649B9CDB474
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 08:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJQI0I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Oct 2023 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjJQI0G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Oct 2023 04:26:06 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC093
        for <linux-serial@vger.kernel.org>; Tue, 17 Oct 2023 01:26:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7BDC832009FB;
        Tue, 17 Oct 2023 04:26:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 04:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697531162; x=1697617562; bh=i5
        Q+rCjguNryD14hJ9ll0sA6V5cYR0bAWqCNpF3lLtk=; b=YHCYpmn3OdY9ztbXi8
        clK+ainWXvQeqO7APN/kdEJx5iHDEVIsFNXWvpq8dZF7x9zpU/omGAd11grV3pVA
        sFwMG7HIi1BczlfXhTgvn43PtHjBSFVmLyFi3ecskqa0pVWiPk9vdCluxOVj7wVq
        pgVXA6fLnhcmm9Bll49nAHbXCHl1rLig5YzzFdXFsox2cLFCmA4GolZOJWt8YR+x
        S5UrzLFWuqbkjRyysn3GQHyhvSulHznhxLIMZWZOe04oMDHK0BDX6KB/STt43M4W
        DRvEJSavnFG+6b4ZJcenhUyyB9v9NIiSTL4jyOAY0KYItZo9GDHi1fDL4GII7h/T
        +4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697531162; x=1697617562; bh=i5Q+rCjguNryD
        14hJ9ll0sA6V5cYR0bAWqCNpF3lLtk=; b=TxmfglWe2jigUm30lHduitCepm5Ij
        E6AZUI03DgLKwF1fVW9arlMDNkcQlyPiNrirpnO0PdbMw3kbPEbd5/RlNk+1x6Pf
        cdzKzXsVr5sWeOQ3X+dPWZp9QFaYaVZR0gwlhkXUjmFpb2yM0QHlb6AAutK5QumO
        /Z5dTGvfa4pNglYOVbJE4dAsMHQmjEowIKB52KbModln1b83IAfTgXwb2k3RSMIJ
        JvwzvmtAtFSNJ8q4F5ninAl49AqTjZIAdSZKLFpSxMidUgdS56n8/De7V31a9XbZ
        li+ReHMx23hG3W9T0jVV9DR1a5ydvDsEBYdfGimmsh/ei6Mdwu2NitmBA==
X-ME-Sender: <xms:GUUuZf2r2t2XWl8UfvjB5pjT2iNV_CPNBjjFTJVe6W344iP2lrAwnA>
    <xme:GUUuZeGk0idgfzc6Lk28-wK93gNghLGnafyW_vcGkagSC7l4hwZmayul6WrtOVF-H
    wsdfGY57lUYBeYX2gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhefhffdvfeejtdeufeevteekueelhfeuleejfffhvdfhhfevvdffkedtledv
    leenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddtuddrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdr
    uggv
X-ME-Proxy: <xmx:GUUuZf6xnkl-z38V5DTY6rJItoeNSDyanfx5JzhpYOQT_ApNry5NDA>
    <xmx:GUUuZU1ph4vCdl09u8re46Fz9pnmFefzMdWtL9h2MuPEfiTnnJE7Sw>
    <xmx:GUUuZSHIgiYxUTHyQtoFzuJZ1YMYTpwrnbvshN39mxz2E-FiuBwrfQ>
    <xmx:GkUuZeDq5ATtKXorBQDaXgQ31vd0VvrGXPT1NAwfOBOFnrX9idhNWQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B9813B60089; Tue, 17 Oct 2023 04:26:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <a2a975ee-9398-45ba-859e-69212a076525@app.fastmail.com>
In-Reply-To: <2023101722-outage-outward-a6d6@gregkh>
References: <202310170938.xHIu2lFB-lkp@intel.com>
 <2023101722-outage-outward-a6d6@gregkh>
Date:   Tue, 17 Oct 2023 10:25:41 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "kernel test robot" <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Javier Martinez Canillas" <javierm@redhat.com>
Subject: Re: [tty:tty-testing 22/24] earlycon.c:undefined reference to `screen_info'
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 17, 2023, at 10:18, Greg Kroah-Hartman wrote:
> On Tue, Oct 17, 2023 at 09:44:58AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
>> head:   6271f1e8c4cb9a46273ae01ff9cb86a022063f75
>> commit: 934d62223da320b3ec012c85b63a6c250f507096 [22/24] efi: move screen_info into efi init code
>> config: loongarch-randconfig-002-20231017 (https://download.01.org/0day-ci/archive/20231017/202310170938.xHIu2lFB-lkp@intel.com/config)
>> compiler: loongarch64-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310170938.xHIu2lFB-lkp@intel.com/reproduce)
>> 
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170938.xHIu2lFB-lkp@intel.com/
>
> Arnd, I'll drop this commit from my tree now, if you want to fix it up
> and resend just it, I'll be glad to apply it.

Ok, I was about to send the fixup below, but I'll just send the
combined patch instead then. I'm still looking at another build
regression from the same series that I'll fix up as well.

    Arnd

----
From 8f8bebf0be1e61fdb38f73e71f05066caebf64e4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Oct 2023 08:11:35 +0200
Subject: [PATCH] efi: move screen_info for loongarch as well

I had intended to move the screen_info definition next to the global
init_screen_info() function that is shared between all architectures,
but as it turns out, loongarch does not actually use this file and
instead has its own copy and is now missing the structure:

   loongarch64-linux-ld: arch/loongarch/kernel/efi.o: in function `efi_init':
   efi.c:(.init.text+0x158): undefined reference to `screen_info'

Add another copy next to the loongarch specific function, the same
way that x86 already has a special case for this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310171049.aNxOKhUY-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202310170938.xHIu2lFB-lkp@intel.com/
Fixes: 934d62223da320 ("efi: move screen_info into efi init code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index df7db34024e61..acb5d3385675c 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -68,6 +68,11 @@ void __init efi_runtime_init(void)
 
 unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
 
+#if defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)
+struct screen_info screen_info __section(".data");
+EXPORT_SYMBOL_GPL(screen_info);
+#endif
+
 static void __init init_screen_info(void)
 {
 	struct screen_info *si;


