Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F15C7EE37
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jun 2023 14:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjFJOyf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jun 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjFJOye (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jun 2023 10:54:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDFD30F5;
        Sat, 10 Jun 2023 07:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A6060C37;
        Sat, 10 Jun 2023 14:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AFFC433D2;
        Sat, 10 Jun 2023 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686408872;
        bh=o/oW4QHzS8ShkvYeDjTwiWPMk3A48v9hrujGZrubDgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHgc7ihKIEwioWyTwsCsVT9J3rPPBbV+8DW/4v9GXRigSegCYmbPmnHjUbPhwkHxq
         OQhjLAJDUkx9ByRAEWFVp5v4EsVYCy76a3RNCu8flVOJuIz9+FEjytFggeoQHYXu9W
         YnhQlpmLZ0OrXhxkfSTXXI4/c8sc3ALNm7nXUiHhrXA77MO22tJYjaP0hUQ39KSM7V
         rsRKyDAag1caTY9eaMCIOqVaHJOa8orLQI6pcJj7npyuGpBVC0+c5+Y/7WiNyk5rbN
         KEawwiMQPozzhYtwDIkQL9CBZKo5uHWB9U5qU8oArc7r6UtxJl1pjGXjoPc1qME2ud
         alo8c2FPvr/AQ==
Date:   Sat, 10 Jun 2023 16:54:29 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
Message-ID: <20230610145429.uvmxxgxc5tc6x5b5@intel.intel>
References: <e4359d5ef206f5b349c1d15a515a1205e78dda55.1686285892.git.christophe.jaillet@wanadoo.fr>
 <20230610102607.7nonyh5xhuhpyy6e@intel.intel>
 <58d3f250-499d-5a18-6798-f9833cc2dbbd@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58d3f250-499d-5a18-6798-f9833cc2dbbd@wanadoo.fr>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jun 10, 2023 at 04:07:51PM +0200, Christophe JAILLET wrote:
> Le 10/06/2023 à 12:26, Andi Shyti a écrit :
> > > @@ -1459,8 +1459,10 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
> > >   			continue;
> > >   		rate = clk_get_rate(clk);
> > > -		if (!rate)
> > > +		if (!rate) {
> > > +			clk_put(clk);
> > >   			continue;
> > 
> > could you also print an error here?
> > 
> 
> Is:
> 	dev_err(ourport->port.dev,
> 		"Failed to get clock rate for %s.\n", clkname);

Fantastic! Thanks!

Andi
