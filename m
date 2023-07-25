Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41900C0015E
	for <linux-serial@archiver.kernel.org>; Tue, 25 Jul 2023 17:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjGYRKj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Jul 2023 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGYRKi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Jul 2023 13:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17CA1718;
        Tue, 25 Jul 2023 10:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7053B61820;
        Tue, 25 Jul 2023 17:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1D9C433C7;
        Tue, 25 Jul 2023 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690305036;
        bh=gFDIOFJUg+DOfAXFPWC3hL0j9ovfHQMSJqI2XgTzQpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+N5g77nllkgBlBRqV1c+fDVHcxuV+oE53LaqoIBIfWcSWr5PXsJzP4RjNKR6/+Ng
         9FJ1gf0hM+UBWpUwZ10DoAq9tTEbGL4EjAiIncisE+kGvL17r/cq6Nm0PfGrD1+12Z
         amKEpM3IfKLNJU6L8nqeg/RcmcoSdVfbfPdrv9zs=
Date:   Tue, 25 Jul 2023 19:10:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Helge Deller <deller@gmx.de>, Stephen Boyd <sboyd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v3 1/1] drm/i915: Move abs_diff() to math.h
Message-ID: <2023072525-gimmick-debatable-0b87@gregkh>
References: <20230724082511.3225-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724082511.3225-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 24, 2023 at 11:25:11AM +0300, Andy Shevchenko wrote:
> abs_diff() belongs to math.h. Move it there.
> This will allow others to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org> # tty/serial

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
