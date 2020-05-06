Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFACCC28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8DA20714
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588766735;
	bh=UJtaQPsyaFA01aGr585C+ElzwVJDEGEsvZ3Z+MYjMo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x+SfC9eClGV/hfqrvZf4mdJo7y6TGHqyjIJr0UUIZyddumyK/DDeiGRehJb/+aYHx
	 UFOQiBiunEJ9KpLRyCf6gyJDIq8blkuaQzPZmQoAB39VghzrrArdCLLB+QI7Bq50CV
	 7z7nTMkltsXTe/L/gLQBZSjBMmJS0yh83VGkVrUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEFMFf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 08:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgEFMFf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 08:05:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B77206DD;
        Wed,  6 May 2020 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588766734;
        bh=UJtaQPsyaFA01aGr585C+ElzwVJDEGEsvZ3Z+MYjMo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkwyJ4unJm70sXCtAaB+SXJCWOIijL7jcBLNZlIGh/c06EsU4pNlDyFeUrQCEhSoX
         0PyB6kxNzt7LhmR6CUfo1fUt6qQd6ZCA7/hxF7Q3G6fjm29dJ4dOIuDmWKE1+11DgU
         jcHuxLTpr/P/2Ki4iMaTjWVbAmnghxDUU31QtN1s=
Date:   Wed, 6 May 2020 14:05:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH V2] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200506120532.GB3047211@kroah.com>
References: <20200506113331.32562-1-msavaliy@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506113331.32562-1-msavaliy@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 06, 2020 at 05:03:31PM +0530, Mukesh, Savaliya wrote:
> +		/*
> +		 * If the WM bit never set, then the Tx state machine is not
> +		 * in a valid state, so break, cancel/abort any existing
> +		 * command. Unfortunately the current data being written is
> +		 * lost.
> +		 */
> +		while (!msm_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> +						M_TX_FIFO_WATERMARK_EN, true))
> +			break;

Am I reading this correctly in that if the bit is set properly, you will
just loop for forever?

That feels wrong, are you sure this is correct?

> +		chars_to_write = min((unsigned int)(count - i),
> +							avail_fifo_bytes);
> +		if ((chars_to_write << 1) > avail_fifo_bytes)
> +			chars_to_write = (avail_fifo_bytes >> 1);
> +		uart_console_write(uport, (s + i), chars_to_write,
> +					msm_geni_serial_wr_char);
> +		writel_relaxed(M_TX_FIFO_WATERMARK_EN,
> +			uport->membase+SE_GENI_M_IRQ_CLEAR);
> +		/* Ensure this goes through before polling for WM IRQ again.*/
> +		mb();

Again, writel() on its own should be fine here, and elsewhere.

thanks,

greg k-h
