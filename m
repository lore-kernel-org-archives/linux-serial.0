Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B568EC33CB2
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE392465A
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgANRhI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:37:08 -0500
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:42062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbgANRhH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 12:37:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2813D182CF665;
        Tue, 14 Jan 2020 17:37:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cent53_3dc9e911f6f34
X-Filterd-Recvd-Size: 1584
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Jan 2020 17:37:04 +0000 (UTC)
Message-ID: <e1b3cccb0814ba4b0c99592715776ed48f343795.camel@perches.com>
Subject: Re: [PATCHv2-next 3/3] serial_core: Remove unused member in
 uart_port
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Date:   Tue, 14 Jan 2020 09:36:09 -0800
In-Reply-To: <20200114171912.261787-4-dima@arista.com>
References: <20200114171912.261787-1-dima@arista.com>
         <20200114171912.261787-4-dima@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 2020-01-14 at 17:19 +0000, Dmitry Safonov wrote:
> It should remove the align-padding before @name.
[]
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
[]
> @@ -247,7 +247,6 @@ struct uart_port {
>  
>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>  	unsigned char		suspended;
> -	unsigned char		unused;

I suggest this not be applied as this is just to let
readers know that there is an unused 1 byte alignment
hole here that could be used for something else.


