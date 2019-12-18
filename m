Return-Path: <SRS0=1HLL=2I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01FDC43603
	for <linux-serial@archiver.kernel.org>; Wed, 18 Dec 2019 10:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673902072B
	for <linux-serial@archiver.kernel.org>; Wed, 18 Dec 2019 10:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edu11RGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfLRKFq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:05:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45583 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfLRKFp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Dec 2019 05:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576663545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSkrFpm1DW1Y7i6HiHHtFhN9Nhr2jT7JhuCbqt9yG0o=;
        b=edu11RGnoPKs0hoROEGujvU+jIRyisxuqOgSGqbu8W8n7Ndqo17SnRUn5ADWMV8fz2maKC
        JPDkMeMJfPczJEIaE4O7y3MjXOVI7ma7wwPw7q5sMpZIJuLmyHtxvnsUo4OtqjBcoD6Dur
        RBXjFsR4YMdo/SEGv83Qo0+gJGl4xgU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-TBBothMrNE-88KafvOPhDQ-1; Wed, 18 Dec 2019 05:05:43 -0500
Received: by mail-wr1-f71.google.com with SMTP id z10so649046wrt.21
        for <linux-serial@vger.kernel.org>; Wed, 18 Dec 2019 02:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSkrFpm1DW1Y7i6HiHHtFhN9Nhr2jT7JhuCbqt9yG0o=;
        b=S81OcEQrTYcQ019TWEbqPROrumhnB6/U+Det8pyIfSUNbQNZNAT+cnvufdEsKm9Cu8
         w+tKGDPqqfefzmM/aFWuLLXXK8TMTxcg/flhNB4AWJj2m4pVcCDrVhlwgXSkL7x3yTn3
         pbvnrY3jRLg7v1WbB6ALZDfzamZyO7inoC4P6qeTFa6XiFIHl/RsrUqvWR5FEqTxL+Ty
         xcbEYcxQjXiGairuWz7SDVbuBXWJa9uYTVNNpg5uQJlKy802UW9cV6wbslDvu2JH3tMs
         Es80Kiy+q/cj9005j5YtEmAJeLfMFOwdV8OYJbS3gMfhyA6D1UDw4kvcWV4QoFjfjW2K
         pxwA==
X-Gm-Message-State: APjAAAUZHrxKpmm5jK5JXnQsN1kWWcmJezGXz7BOnE9cOiAiV8tiaBPR
        TSb+Ag8XqeMjKBpHQOp27GibtHOxEIngjqcdB+Gq/Zm2bewFudZaci3JqWNSk4gHeqmS/RGHmft
        RaYt35KqpZ+GgLhPbYLvfZjpA
X-Received: by 2002:adf:f54d:: with SMTP id j13mr499110wrp.19.1576663542540;
        Wed, 18 Dec 2019 02:05:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxX6RhlxdEWJs66pu6RNx9WXgk/AjvVABJfgEXDOjUWKh9KkobAdo1xitp5e/cWXJ63qptzmA==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr499080wrp.19.1576663542320;
        Wed, 18 Dec 2019 02:05:42 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id 5sm2130892wrh.5.2019.12.18.02.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 02:05:41 -0800 (PST)
Subject: Re: [PATCH] serdev: Don't claim unsupported serial devices
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        linux-serial@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, shrirang.bagul@canonical.com,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
References: <20191218065646.817493-1-punit1.agrawal@toshiba.co.jp>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <096046b6-324a-8496-8599-ed7e5ffc6e3c@redhat.com>
Date:   Wed, 18 Dec 2019 11:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218065646.817493-1-punit1.agrawal@toshiba.co.jp>
Content-Language: en-US
X-MC-Unique: TBBothMrNE-88KafvOPhDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 18-12-2019 07:56, Punit Agrawal wrote:
> Serdev sub-system claims all serial devices that are not already
> enumerated. As a result, no device node is created for serial port on
> certain boards such as the Apollo Lake based UP2. This has the
> unintended consequence of not being able to raise the login prompt via
> serial connection.
> 
> Introduce a blacklist to reject devices that should not be treated as
> a serdev device. Add the Intel HS UART peripheral ids to the blacklist
> to bring back serial port on SoCs carrying them.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thank you for addressing this long standing issue.

The basic approach here looks good to me, once the minor
comments from other reviewers are addressed you can add my:

Acked-by: Hans de Goede <hdegoede@redhat.com>

to the next version.

Regards,

Hans



> ---
> 
> Hi,
> 
> The patch has been updated based on feedback recieved on the RFC[0].
> 
> Please consider merging if there are no objections.
> 
> Thanks,
> Punit
> 
> [0] https://www.spinics.net/lists/linux-serial/msg36646.html
> 
>   drivers/tty/serdev/core.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 226adeec2aed..0d64fb7d4f36 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -663,6 +663,12 @@ static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
>   	return AE_OK;
>   }
>   
> +static const struct acpi_device_id serdev_blacklist_devices[] = {
> +	{"INT3511", 0},
> +	{"INT3512", 0},
> +	{ },
> +};
> +
>   static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
>   					  void *data, void **return_value)
>   {
> @@ -675,6 +681,10 @@ static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
>   	if (acpi_device_enumerated(adev))
>   		return AE_OK;
>   
> +	/* Skip if black listed */
> +	if (!acpi_match_device_ids(adev, serdev_blacklist_devices))
> +		return AE_OK;
> +
>   	if (acpi_serdev_check_resources(ctrl, adev))
>   		return AE_OK;
>   
> 

