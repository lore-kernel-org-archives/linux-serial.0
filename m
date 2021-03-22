Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55472C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC58619A0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCVLXg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhCVLXd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 07:23:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE59E6191F;
        Mon, 22 Mar 2021 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616412213;
        bh=82zLdo1yFJpr6pZvArjJ8Qc8IXTnk3s3Wc2YLiwo6TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUOH6WHkIqZKfFDkBumYj6cU7V0acb3XSc6IEtt6h4BXow+9ZUPXu/EsXU978tTjf
         YovOuh6Cv37A6fthgk+bLvxNhGQ6lv+Yn/zM8lLJh8rVDHs0q+0Vj0igy7fgJZSR7l
         OdM54GDLMwIEfO0Q8EsKEm4oeMFDp9E0CWoEDiY8CNKMmP6OsIiTv/SSbjVc5h8p0T
         C8LoS1MrM1aufoJ4xw3T50vurzkg0AttIJ1SGzhoc+HJTLaLE1R/SqVv9UhFwMSUay
         N7wNdMvv8pdgCjBIymPfzQ/YqUDFkazZ1IF367JljjEw2vgXOfBNqEHcibX2geov5X
         Hjo0K/5zeXKtw==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOIez-0008Or-CG; Mon, 22 Mar 2021 12:23:50 +0100
Date:   Mon, 22 Mar 2021 12:23:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcan@marcan.st, arnd@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: samsung_tty: remove spinlock flags in
 interrupt handlers
Message-ID: <YFh+RZGGvBaUJpqq@hovoldconsulting.com>
References: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 15, 2021 at 07:12:12PM +0100, Krzysztof Kozlowski wrote:
> Since interrupt handler is called with disabled local interrupts, there
> is no need to use the spinlock primitives disabling interrupts as well.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Interrupts are now disabled also with forced interrupt threading even if
this never was an issue for this driver which currently doesn't take the
port lock in the console paths.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
