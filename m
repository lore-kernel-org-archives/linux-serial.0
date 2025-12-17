Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4E347FE3
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956967; cv=none; b=sa1BG//DK23hIU+i8Lu22i9rx8guzRDyjRYAZv9B5VLM4oXN/2KnugajczXnlxv96g+F4iBpvc+IfeC+6eD8UzYbArOfxFWJ2tvgb5owPhBc3GVuGg9oDdM402fBRtEDQ+vbKcrPQdf0DQs7UXCkbqZd9+c1X8a3mvox9GVIA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956967; c=relaxed/simple;
	bh=Vj99uIVLpyM5fVIEraK9l4Rt5e8dS3EZWhTtbZaSxfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaqUafTFePVT8tW15C/P3006/7sus3SkWcmUOxGFM43JUTlIGCmSgfegfKKQZk3M8BEhaMR1390qTvRvwYOfjvL0Md3QZdhnwDgepbCjDy4kHYqNU7CGOUj9gN11cENtLLAGp2mYGDGM/CqL24911KPEXVqtnWbeH++IUwSFnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSa18gQe; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSa18gQe"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5e1fde1f014so1690425137.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 23:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765956965; x=1766561765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dNyhTpSpLnqz679/e0vOnYIzAms/0r86aw8voZM4hA=;
        b=MSa18gQeQlZXngHlEmc5YDV7b0unP3KRx1BfnmaGwiX49pnCs19iG9yhVUDSiz9TWD
         XogKhlEkff7GAVfVwr0UpR0YN3GaDwz44MhptuCiJ2MoluNZc4iVek8YJQX4L2XL3mok
         eFJJl6m/jY27+MhmtS53BhfGPEI3iLgZc4fsvixIkMpgPBNroCABN6ZZKq6Q+M+GhEwS
         PAxRUnsOvddqhLsVNsHGq0F5Ksg5kklTgG9snfma+/WNZOzh7xWPsEHsspzq5jwi4QK0
         C7v20fG/ij3kPzxc6Q21To2wsjoNyd+qhv/1brgRcxsFRBAJ92PhkZCCmhjdNGyIhEM2
         Bs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765956965; x=1766561765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dNyhTpSpLnqz679/e0vOnYIzAms/0r86aw8voZM4hA=;
        b=aAdG6kho6bJBZmMYVWSGNrdX5rHINd5E19o8cckZW5j7OOMJD6q2NSFCWPQvqUTrNo
         IEO5h5KOCNirEubwG0wNvaQ2LOMx+ShXkZ5A3rqE49u2/lHNCHxYLtUwwMXebJbZEZdB
         Y/BlEyWdMptMXchLV1FXLCUbsK43K2qonvWAFgQ9PUNV8i/noxXnf3cvbt+/IVEsso+z
         kQGYbg/h9yqHsL2skcNgtAl9tIWXOqMbf+VA322utjC6quSdmVPuEbtmOZcbA8xKSYIz
         nuekcOVSA13O3rlI7qkvxMKDgg1lBqRgcH6AH5dpw54fbyKvcEpNDhP/MZiXOBu7U8Bb
         +2ng==
X-Forwarded-Encrypted: i=1; AJvYcCX5AHyLrJLtlgMd+SKe2A4aXSxQMuyjA+QSHjpMCitwywHVtIHwZ44WHyU4P3gNZgkAD9NwyybmnF1Otyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4E/GJKZNmQKsp5ta+uE4gpsGTXRY9a3MOkZnTwSDfHsmNhB9H
	cAnvvSzw/jSjPxPKJHd1uKQwz95LuDES1F6m0GYJWuPi+o7PYthNQx4nNXfC7R0Gmi5CVSEbSsi
	oPOmg8yHhylEfk79ol3CmPiUmxygSRiY52/hYTCM=
X-Gm-Gg: AY/fxX62lcTDMtALMk6kUG1ybf2AkwYDDiG+f0KNQEDoFiQ7abp2qFijaFcQJMM1d5v
	KvwQn1FdCRbWfwogaOnyF/zlFGZVWxJ8LXBck4esJE6wtpKmdt0JTMrT4xQ+zV7rfPzYMoUa78R
	+1+vkMDNgJNJUmJwsijjai71aFstqHhpi4xONqZ0nLBcwzTXK1A98xhrp9A0WXfdqUz8PWqpgS4
	iJhAloSynybURXBi8DX49e3MWweloioBQ8ZRCRXsB5zSCuKXn6LIaUtL0R/13rq2wXph6mSW77K
	pm1CBO1FR/3Zp0QHKUsOfuyWz256kXo+prh880dM6n/NFkX8xFM8luI=
X-Google-Smtp-Source: AGHT+IHoOilXX2tYt6VKs/+VZVH5E6fzTigLpYxP1N0APgZuOX45PqYNuxz2CQWPNv8m/FuqMJFOaTMYnLo1o2ptUh4=
X-Received: by 2002:a05:6102:26c2:b0:5e5:66c6:d23e with SMTP id
 ada2fe7eead31-5e827696622mr5162798137.1.1765956965026; Tue, 16 Dec 2025
 23:36:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202063748.1210359-1-kubik.bartlomiej@gmail.com>
In-Reply-To: <20251202063748.1210359-1-kubik.bartlomiej@gmail.com>
From: =?UTF-8?Q?Bart=C5=82omiej_Kubik?= <kubik.bartlomiej@gmail.com>
Date: Wed, 17 Dec 2025 08:35:56 +0100
X-Gm-Features: AQt7F2qfPoGe3ZAHY4GZ7cQyUXN8h0AdGuZ-5_qQ4hLnf3ADLAFZIJkewT4znR0
Message-ID: <CAPqLRf18v3eQaKsaaf+wB6k5+v65=BkQG2dtS=Bcyee=isOatw@mail.gmail.com>
Subject: Re: [PATCH] tty/n_hdlc: Fix struct n_hdlc kernel-doc warnings
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I submitted this patch about two weeks ago but haven't received any
feedback yet.
I wanted to check if there are any concerns with the patch or if any
changes are needed.

Please let me know if you need any additional information.

Best regards
Bart=C5=82omiej Kubik

On Tue, 2 Dec 2025 at 07:38, Bartlomiej Kubik
<kubik.bartlomiej@gmail.com> wrote:
>
> Add missing descriptions for write_work and tty_for_write_work
> members in struct n_hdlc.
>
> This fixes the following warnings:
> drivers/tty/n_hdlc.c: warning: Function parameter or member
>                                'write_work' not described in 'n_hdlc'
> drivers/tty/n_hdlc.c: warning: Function parameter or member
>                                'tty_for_write_work' not described in 'n_h=
dlc'
>
> Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
> ---
>  drivers/tty/n_hdlc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
> index 4a4dc58b866a..ac0605ac9d46 100644
> --- a/drivers/tty/n_hdlc.c
> +++ b/drivers/tty/n_hdlc.c
> @@ -127,6 +127,8 @@ struct n_hdlc_buf_list {
>   * @rx_buf_list: list of received frame buffers
>   * @tx_free_buf_list: list unused transmit frame buffers
>   * @rx_free_buf_list: list unused received frame buffers
> + * @write_work: work struct for deferred frame transmission
> + * @tty_for_write_work: pointer to tty instance used by the @write_work
>   */
>  struct n_hdlc {
>         bool                    tbusy;
> --
> 2.39.5
>
