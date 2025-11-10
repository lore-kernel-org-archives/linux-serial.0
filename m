Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1A24BC07
	for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783525; cv=none; b=sM6vqivgtmVhmlsSLZqpw6wICLa2V43nrWMWlaChh0yRwxKtcquCbGN3j3zHZkeXY7L8UzxFppEVbi93va/yJyWjMpEUqgQp7hnPg6qxqY6PQc+0YB1qR4jDXfd7lQQCCesSfFA8uNDPJ4yB/1RMj7zZqwgRnZ1842iszolLOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783525; c=relaxed/simple;
	bh=1HKyg/y+K486ffMg3gd1pV9isJ6E8/RZqZT9tEAPbcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqOsUlFlxgB3prxaxBm3kwkenitt16+v0/wDqAeFXWLTIzLzum0PVTVqIJAqgyYoo0yV8o0hp+5N4MGe8Bl+fsN9TfXQsMSCgLlrBZrgf8Ev058sJm+mQm/tRo4DmPVkEiqHSPKBxV5vrzlBc6as1xfr8yvn9WNdIYuezv7Rjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKK1ilQn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKK1ilQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762783522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JtzOcemGD0TJWG3B+UVtVletzjnKYruntoqmhaEm2o=;
	b=GKK1ilQnsbEhSeWmEqXofwadtUH9S9aa6mzXcwSuFe4UvnS+uVUbYsmCvCZjPsJjr2NQhd
	7nXqn5gqX41/3aKU5GkSLoN2rGBr7EJcNAGqTGXdW9JAV8T/MgY8HEInqGbuMTr7mrRVbz
	7IxvxdWgtLgZeOO1r4d/6sIowdvUvUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-0g-NcqKDOOyNqmKZ9PNv6A-1; Mon, 10 Nov 2025 09:05:21 -0500
X-MC-Unique: 0g-NcqKDOOyNqmKZ9PNv6A-1
X-Mimecast-MFC-AGG-ID: 0g-NcqKDOOyNqmKZ9PNv6A_1762783519
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475dabb63f2so14023465e9.3
        for <linux-serial@vger.kernel.org>; Mon, 10 Nov 2025 06:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783519; x=1763388319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JtzOcemGD0TJWG3B+UVtVletzjnKYruntoqmhaEm2o=;
        b=owtnCKxyUHMFA/OmU9yctyQKxu4E8F/cxcFMWpZZOWfyGGIPb/1KbkAThp+rpEs0Ro
         LlKzkv2X8m/KRiITMS3yzg1q5XwjnjISVnVnfYrReV0lIrqlZtIlr4xPqao8jmifbZ49
         FBkHj6eW7pOpGm1EOQvxNpsm+qhZ2F/hLukQ9Th1Yx8xUliRc6NIVUD43fxxIi8Kfnqd
         6drm8rIILq52hN9FzMUuprtmnhZLbYrgYTxCF9BB2bvOuaRDdoc9GWRZoLYWOhbdNI7E
         GYsox5qa4Sq0M/p6SDLzh+IGRVD46UEbhQh/178qRJqmGdmfCm1ib1wKKz+92VQY3BqN
         u0EA==
X-Forwarded-Encrypted: i=1; AJvYcCXQJosd21TmhnIq8//IjvRGnXL60DOZc8dkGjyxUEXPOPoP78GahaHQ+Fghdl4ClKlZqVRon4Q/pv20NZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfrF1nAK4EQUq90/wXEmij8rH66e/NgjJ2Ca3r96ZTVARdVGE
	jCFuo5ubph4jRrbiK7dwScHEuMByYjFjJBanX7g1JNRiJwQlx5N2vvPBdJvcgtFB9TpyvfV4PGF
	zucdgiuhgsGI3+NDY9mNbKuk4tsw2bJF29nOQrQqHr/DIFawZ/O+cG/QXw/c316xMFA==
X-Gm-Gg: ASbGncvp3xyGfowYY2ZkG0WA/v5WmyReGW313+uY5v8ly4EjsMaveRQV1pyIaL3lJ/v
	QZbRlJutWPABUYUZ8RJ5dbVcRwDAZVnVy4HNGF+8PHiQWMrgK0qiwhzZUcJkIsRzEbehbBXXfyB
	ZxSumu+vQU5tLbc6CiYKiy1MYB8dROokmRFxnjb1Dp2d80HnefjOyr+B4jzBjBuSPHssPFedIZW
	co7H9WLUQFYD5c41ouAnypwYv+yZEXEnGiI26sbfajO2iSCLKCI8HS/8jwcZmJ3zzvmjJBVdBed
	8xPRNHRGI6DgRKf/69lVwz+1A5p2UzO5iplGW2ol29N9Lu8IoL7ii0Qd256h+cIe0EL8XMrXpVH
	2UBuHrv3wTmfqQ2IeDnj4VrKLhi/MJwYa/AnPCM4=
X-Received: by 2002:a05:600c:1381:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4777325ab51mr76639815e9.18.1762783518789;
        Mon, 10 Nov 2025 06:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMjn+CCsjUlMm3xzTYdWVzE/NNKmYzLaSSOr86S2ftoTTogHmleVtc8GMhLnQCQcUAUSFpsw==
X-Received: by 2002:a05:600c:1381:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4777325ab51mr76639435e9.18.1762783518357;
        Mon, 10 Nov 2025 06:05:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4f89fsm116138455e9.3.2025.11.10.06.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:05:17 -0800 (PST)
Message-ID: <0749be61-2f3d-440e-887a-c841007e5b50@redhat.com>
Date: Mon, 10 Nov 2025 15:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/client: log: Implement struct
 drm_client_funcs.restore
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 simona@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20251107142612.467817-1-tzimmermann@suse.de>
 <20251107142612.467817-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251107142612.467817-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9nGLFrEQG3yW3rhzCo7N2s9bAPDLQj8tGTcx3PLepT4_1762783519
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2025 15:19, Thomas Zimmermann wrote:
> Restore the log client's output when the DRM core invokes the restore
> callback. Follow the existing behavior of fbdev emulation wrt. the
> value of the force parameter.
> 
> If force is false, acquire the DRM master lock and reprogram the
> display. This is the case when the user-space compositor exists and
> the DRM core transfers the display back to the in-kernel client. This
> also enables log output during reboots.
> 
> If force is true, reprogram without considering the master lock. This
> overrides the current compositor and prints the log to the screen. In
> case of system malfunction, users can enter SysRq+v to invoke the
> emergency error reporting. See Documentation/admin-guide/sysrq.rst for
> more information.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 19e55aa0ed74..4d3005273b27 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -315,6 +315,18 @@ static void drm_log_client_unregister(struct drm_client_dev *client)
>   	drm_client_release(client);
>   }
>   
> +static int drm_log_client_restore(struct drm_client_dev *client, bool force)
> +{
> +	int ret;
> +
> +	if (force)
> +		ret = drm_client_modeset_commit_locked(client);
> +	else
> +		ret = drm_client_modeset_commit(client);
> +
> +	return ret;
> +}
> +
>   static int drm_log_client_hotplug(struct drm_client_dev *client)
>   {
>   	struct drm_log *dlog = client_to_drm_log(client);
> @@ -348,6 +360,7 @@ static const struct drm_client_funcs drm_log_client_funcs = {
>   	.owner		= THIS_MODULE,
>   	.free		= drm_log_client_free,
>   	.unregister	= drm_log_client_unregister,
> +	.restore	= drm_log_client_restore,
>   	.hotplug	= drm_log_client_hotplug,
>   	.suspend	= drm_log_client_suspend,
>   	.resume		= drm_log_client_resume,

