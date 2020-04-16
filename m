Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B68BC2BA2B
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 20:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAE5206A2
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 20:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587069505;
	bh=9i3CfymeGe/NEpMGnyUqethDDHOzRWWGJhLiiXR7+QU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZEhz1X+f0T3Zl8QdcTbArrXvQBmA5HSubPRX3QCA5Zk5sbOH266w47I0n5+deWm14
	 WdLMLUquKUQwNJREqGjD2rW1YT42h72Mqv27uskXuqT3JHIOQ/WbXIlfFqOAS/ZyzD
	 LzEuTxZ9NW8Y0gx7OfJnJHHD+hjoIe8oVB5A2Is4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgDPUiV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgDPUiV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 16:38:21 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7557E2220A;
        Thu, 16 Apr 2020 20:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587069500;
        bh=9i3CfymeGe/NEpMGnyUqethDDHOzRWWGJhLiiXR7+QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AtYRlm3JeEbYNmK1uFVhGVztI222HVj0FYwHr9mzeclmUYYZuRqTLCpQSm86Z7sc+
         Du0qNp5IZ0S8HL2Hch2Cqk9T6fxX/q4QaM3OPYLhsccpaNS9nI9FuK8u3ZO5VRHeaJ
         coliPMrSFWdwbUFi9HGRYwz/F4taGg50ckffHISM=
Received: by mail-qt1-f171.google.com with SMTP id b10so59049qtt.9;
        Thu, 16 Apr 2020 13:38:20 -0700 (PDT)
X-Gm-Message-State: AGi0PuaYL/mneGQ4+9jemTNYXirtiDM9x2OzMejLLG9mlMOsFyMhLqoP
        Ah2DSLuRgPp9Y4nQnTfDnI7eBAzH4pclhikF0Q==
X-Google-Smtp-Source: APiQypINcM/3te3/8Ff4YCoykqXgpcs+an4Ryq2/zxonzK/oqiiErlVLJql23/90o1z0HIyweV5zlL9XqTC+jP72nKw=
X-Received: by 2002:ac8:4907:: with SMTP id e7mr28608227qtq.300.1587069499594;
 Thu, 16 Apr 2020 13:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
In-Reply-To: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Apr 2020 15:38:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWMTpHG=bOmWgy1kg6d7vxRGbCda+febq=FnqbuRbPyQ@mail.gmail.com>
Message-ID: <CAL_JsqLWMTpHG=bOmWgy1kg6d7vxRGbCda+febq=FnqbuRbPyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: ttyvs: document serial null modem
 driver bindings
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 15, 2020 at 11:56 PM Rishi Gupta <gupt21@gmail.com> wrote:
>
> The ttyvs driver creates virtual tty devices. These devices can
> also be created through device tree. This commit document this.

Device tree is for real h/w devices. You have a configfs interface to
set these up. I don't think we need both.

Rob
