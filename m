Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4738CC47082
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 15:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2924860231
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 15:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhFHPLT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Jun 2021 11:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233731AbhFHPLR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Jun 2021 11:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623164963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xd27TZrjyUSgEfYYAlDih1uCJIzOgdMqOa7b64kFQcM=;
        b=eEcaGh9ZkieInSxR9zdVV6E7nHWNoVQ9pukrXeTd0+yW+h7+woxw3J+o4l/7lpEFcaf5WZ
        cewH53QNOZ72YpBYJIo0FmCG2T2lH870/b6iEyziWQpOda5VvBEHPu3WnDBzBl7k7E/GKS
        /gnkNxha0C1JskXEj+NN5EjEG0IKjuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-89hwJhIZOdWHCtsjwSCdQQ-1; Tue, 08 Jun 2021 11:09:21 -0400
X-MC-Unique: 89hwJhIZOdWHCtsjwSCdQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27DFB107ACCA;
        Tue,  8 Jun 2021 15:09:20 +0000 (UTC)
Received: from starship (unknown [10.40.194.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3545A60C04;
        Tue,  8 Jun 2021 15:09:17 +0000 (UTC)
Message-ID: <0dd7c5efd36aeeaa963643c482bf8ca3fcec69fa.camel@redhat.com>
Subject: Re: [PATCH v1 1/3] serial: 8250_exar: Avoid NULL pointer
 dereference at ->exit()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Tue, 08 Jun 2021 18:09:16 +0300
In-Reply-To: <20210608144239.12697-1-andriy.shevchenko@linux.intel.com>
References: <20210608144239.12697-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 2021-06-08 at 17:42 +0300, Andy Shevchenko wrote:
> It's possible that during ->exit() the private_data is NULL,
> for instance when there was no GPIO device instantiated.
> Due to this we may not dereference it. Add a respective check.
> 
> Note, for now ->exit() only makes sense when GPIO device
> was instantiated, that's why we may use the check for entire
> function.
> 
> Fixes: 81171e7d31a6 ("serial: 8250_exar: Constify the software nodes")
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 2f49c580139b..bd4e9f6ac29c 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -553,7 +553,11 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
>  {
>  	struct exar8250 *priv = pci_get_drvdata(pcidev);
>  	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
> -	struct platform_device *pdev = port->port.private_data;
> +	struct platform_device *pdev;
> +
> +	pdev = port->port.private_data;
> +	if (!pdev)
> +		return;
>  
>  	device_remove_software_node(&pdev->dev);
>  	platform_device_unregister(pdev);

Hi!

I just tested this patch and it does work!
Thanks a lot for fixing this that fast!

Tested-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

