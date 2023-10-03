Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A7AE75455
	for <linux-serial@archiver.kernel.org>; Tue,  3 Oct 2023 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjJCMjk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Oct 2023 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjJCMjk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Oct 2023 08:39:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D039B83;
        Tue,  3 Oct 2023 05:39:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EE1C433C7;
        Tue,  3 Oct 2023 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696336777;
        bh=ECR/7x6lqKutCE21tMiDm+DwzncvCbKErAMvXLYb+2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHaZUXRoRH9Vl0HrtucLND8/yKXBcIxTpnk4vjfktbwkrc03Or7eFVhPieeWFLOIA
         hxA8FTCYrtRVQT6wt9EOEbOAOw55YRujZrJT9MfX8Yg3wIRdBkiAt/F59kNfUtCmr6
         75tR7xCcakG65rDs8mBITWb1WWktuIVgWfpRlbYs=
Date:   Tue, 3 Oct 2023 14:39:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4 1/5] serial: core: tidy invalid baudrate handling in
 uart_get_baud_rate
Message-ID: <2023100322-roamer-dab-b96a@gregkh>
References: <20230928151631.149333-1-jcmvbkbc@gmail.com>
 <20230928151631.149333-2-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928151631.149333-2-jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 28, 2023 at 08:16:27AM -0700, Max Filippov wrote:
> uart_get_baud_rate has input parameters 'min' and 'max' limiting the
> range of acceptable baud rates from the caller's perspective. If neither
> current or old termios structures have acceptable baud rate setting and
> 9600 is not in the min/max range either the function returns 0 and
> issues a warning.
> However for a UART that does not support speed of 9600 baud this is
> expected behavior.
> Clarify that 0 can be (and always could be) returned from the
> uart_get_baud_rate. Don't issue a warning in that case.
> Move the warinng to the uart_get_divisor instead, which is often called
> with the uart_get_baud_rate return value.

This doesn't match up with the patch contents anymore :(

