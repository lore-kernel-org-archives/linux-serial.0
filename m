Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4242E41A
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682400; cv=none; b=O3ealUKZSQJiuWkaU8wZQ6zXCKiIl4PfQzT5+BRPEn88vbbbDQTn8vRRuBrjpz1NIuVqp0/tmp+ik0eDaWV3uGZDokn0kwXXNR0SINgY1Ljv7X2UMKQQ1h4RBzLsvcIlk0Bpv3UeaW5WACJVKEW64fDvZHn1WFsLByBNhuVuqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682400; c=relaxed/simple;
	bh=ip41HoXWI4YcOSbW1mEcNQBv0yfH8oGIibej8w1DMvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYbiN4aPX20uWboCc0iTpBBR3TwKllrfkEttwr8rBYanEuWRwiQx3uFwueQ7UvZx8tE+jgJFM7XwnVdkvvxkoh/JCtRmA/iEn1RkquiYOzvzg1P6jAmohl5JvF34RpZb9tnrwDhZq8cMIVKBGsXy4f9sJmmkSsWwIH3GVDt1ngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NQjWTQ5K; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NQjWTQ5K"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98604f6b4so116662a12.2
        for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789682396; x=1790287196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r4cnNziyY5ivazygxhgE+WIDjeZucbip+tFrsvHGAeg=;
        b=NQjWTQ5KaNJx/xFUDDDkO8IPmAGUQ3xBy2g5N7ErqIDEw1ZwHfUxvqgvm5IvlFl/Nb
         lXIqeusETYfRQdxBLqdVSNQis3OrgbJMsZKgqugokHKru/RnPuAaa7uHMl4nZnoNxpSv
         tkHDKnwWmHFhFqn2CbH3TjuiYICa4/BxRTFGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682396; x=1790287196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4cnNziyY5ivazygxhgE+WIDjeZucbip+tFrsvHGAeg=;
        b=oFfzW/NMG2+En3/ZmmE63gDNRndATijIC5O8huwlU+VtimkADPlmBK2B2/F7Lb78yq
         rDMZgz7O9tJo73KC95py7ZF066VGk3BkCcot6UIoKufZTCB8SdjBKfP9pnUZfyuYKnyc
         17bnmYwlZf35x6hsw6HGONpUTkdV0rxXAbO7ouRU/E7hAE/9mMJKJH2Zwoe+xMyGI4OH
         G/w8xxPDjki1tLDwewyCBYB8UmUEZtFOqwpibqWSI9nlGnH341LvWbTzZq5p061XmwE7
         cfuM2MM6Ccu0saqHHV9d1w8Pnv/4xuADZyYL6zRVQdGgrFBLa2QpsvOyOxnUNx0+PVZZ
         LIog==
X-Forwarded-Encrypted: i=1; AKwUvBznMqL4gM8B5hoBxhXvLdKDCjkrjBVUG/CNGJNzls8VyGCtnD9RSGfcK4FdHPmXZWxKA9z9zLohUJKauvM=@vger.kernel.org
X-Gm-Message-State: AFuF++n99c7AYDyMkrDJmlR9Qr+pGMp6sytCbWkHxKU6jd5TrXyjWmUn
	siMYEN1mLEtSGzlFS/l5FBWTlcNWThs3FQ03xx5GmxeW4ZDoRzEFr89S+idI0oWcesnCDrO8B5V
	IDqikOA==
X-Gm-Gg: AYBFou295A1WMYhqkaHunp6ZM43h80XOqrsvY2wA00FM5iyp/cVONl0ziSTmqEfWY7h
	b2UZZn+bpOFQNk+85EOgoXhVTmAJ/vaePTGkfq2mVV4egj6iLxulKah2iqdjkhbhmsDoqmT8QRC
	c1916KwXB3TXCa4RqaGyxeFnYosbi9UzSWSkCqcd1DWZ4hJB2+rhBrbEfI7jkWFwRWHfq92OVBD
	YnIL1/hbEtn501ZoGqZx7OE0k+065YFTc99s4bdor649P4YkBvQHNMBLrvK5W0F5FddObpmhHYd
	VJU33P3z8Ry1WQLHF1iaHcE/I6lsWev7rl4ZoLGzZa5O71UOfGoBXtLgyyhh4StMx9tGxD/kV6g
	1Xlme7mmLoVG6+Xw56UEvUAgzmG33iPLrLN3U1b65HF57ilU7uSu7pAy6ppbWpr+U0EmFAt6e+S
	TDdv9NHOwOnqVZQ+oQ5qGNdO/p7rznVylO6bRybFX76QuUOp0z5BhHETXw+WAe1EqK946/UsHqL
	bHHfr9R6vTI0aWpnuwyd5DKB5TTU67TtUxjBA==
X-Received: by 2002:a17:906:9f8c:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c2a158195famr58601166b.7.1789682396322;
        Thu, 17 Sep 2026 14:59:56 -0700 (PDT)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com. [74.125.225.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de48af2asm350029166b.26.2026.09.17.14.59.53
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 14:59:55 -0700 (PDT)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f88so23286f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 14:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx8szHdoFJMSI8j9oyaqhEQW+JCPFE1hW7qmzr8Ixfn0RxOfRBR+lVPk7OOAtLEm4801gQcgPuY9xjaSVA=@vger.kernel.org
X-Received: by 2002:a05:6000:2211:b0:487:a49:69d3 with SMTP id
 ffacd0b85a97d-4871e373af6mr289328f8f.55.1789682392891; Thu, 17 Sep 2026
 14:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917155523.2161202-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917155523.2161202-1-vulab@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 17 Sep 2026 14:59:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTr4Q7gOQts8HasSQoeovYMLu7ic8V2fkuy2TgyUuB3A@mail.gmail.com>
X-Gm-Features: AcwNN1UiO2RFa1YhyTUqFm7bdR6dSYURtFzuPkFnJib2ceEhsCbcSdyptjfk5VE
Message-ID: <CAD=FV=VTr4Q7gOQts8HasSQoeovYMLu7ic8V2fkuy2TgyUuB3A@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: Fix tty driver reference leak in configure_kgdboc()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alan@redhat.com, danielt@kernel.org, gregkh@linuxfoundation.org, 
	jason.wessel@windriver.com, jirislaby@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 17, 2026 at 8:55=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> tty_find_polling_driver() returns the tty driver with an extra
> reference taken by tty_driver_kref_get(). configure_kgdboc() stores it
> in kgdb_tty_driver but the reference is never dropped: it is leaked when
> kgdb_register_io_module() fails, when the configuration is cleared, and
> on every reconfigure.
>
> Release the reference both when unconfiguring and on the error path.
>
> Fixes: 7d7b93c1452f ("tty: kref the tty driver object")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/tty/serial/kgdboc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Looks right to me. Even the "Fixes" looks right since the tty change
landed after kgdb was added to the mainline kernel (by a ~6 months).

Reviewed-by: Douglas Anderson <dianders@chromium.org>
