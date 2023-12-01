Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SipIncEy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEA10F9
	for <linux-serial@vger.kernel.org>; Thu, 30 Nov 2023 21:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701408030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X88JSiziG/o7myWzNFddeB9QrNNoNgpJlb1gQar3PoQ=;
	b=SipIncEyQG8U+Kk09VaiyDag81ve/asNCSN0budBAiZiN8mWFtm6hc3W9nPTPdctll8tX5
	LOm1i8VvkEoCCLM7nQ39va9zrmRC31m4fjamI87L839LGomPue71rwDz9pviwi8f4jdkcV
	cTMft4IT1R0UT+n7Gajy6bORSY8gBJY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-ANUXrF0cNjiZ4nqU9jkOqg-1; Fri, 01 Dec 2023 00:20:26 -0500
X-MC-Unique: ANUXrF0cNjiZ4nqU9jkOqg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bd190f115so1154199e87.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Nov 2023 21:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701408025; x=1702012825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X88JSiziG/o7myWzNFddeB9QrNNoNgpJlb1gQar3PoQ=;
        b=hasmiEZBcNLs6QWsZ8rfugKandtvhchQf7DupcX0lkZAKcNgLrDDptNjQ/ckhpTJeD
         s0h/0EN+AOOK8fyTiKXYQacc+hdmzyc7dfuq1KjmdL5LK6CdfkMIMGy58LK0Jvk2CMFA
         51PwhSd2EkUVGwOiwV2TVVXDm09JzqLCUXqu9YX7KZKNYbCL1ALAKeW8AskzP7BXt8cJ
         LUwNY9NVnkRWQQAC8bfMYb3gUXmsZZrbiMUTc7ykQ/JkeeNjcX4VF9rGhC/xbJd8gtCC
         EoOB46gQeSOg1mJxUcG8JC1axcVfcR2k4y7F0mZnAVleccUapFKIFYYoGipOKWQRru3f
         uctA==
X-Gm-Message-State: AOJu0YwAKtJ/EM2ev5of57WNH9H5twDkZepLcvl56Ya99k/kCT/1VLZj
	BxyiRJ2fDpswMJGORKcKPAsuSTLZIglKfSjX9lmDTNNvbxdQRJjPelzEwoUds7b4yPZ1sS3nEnJ
	nNLlesVxn+K3oppxKQXjbNGfR8BeyYiE254q47vCo
X-Received: by 2002:a19:a408:0:b0:50b:c9b6:3216 with SMTP id q8-20020a19a408000000b0050bc9b63216mr343643lfc.8.1701408025517;
        Thu, 30 Nov 2023 21:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESdjRg/qOdpcOoc9ha3XIN7XwU3jvK2LnYcltjH/CQeP85eYFX50MTqViiFNs+mh7TXHCkLsXficufvdwpKuo=
X-Received: by 2002:a19:a408:0:b0:50b:c9b6:3216 with SMTP id
 q8-20020a19a408000000b0050bc9b63216mr343629lfc.8.1701408025249; Thu, 30 Nov
 2023 21:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130113001.29154-1-jirislaby@kernel.org>
In-Reply-To: <20231130113001.29154-1-jirislaby@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Dec 2023 13:20:14 +0800
Message-ID: <CACGkMEtc962wXcFP7kQFcyxRqqyXAF55kpZwv-tQbcCWuOHGTw@mail.gmail.com>
Subject: Re: [PATCH] tty: virtio: drop virtio_cons_early_init()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-alpha@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 7:31=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kernel=
.org> wrote:
>
> The last user of virtio_cons_early_init() was dropped in commit
> 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport").
>
> So now, drop virtio_cons_early_init() and the logic and headers behind
> too.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: virtualization@lists.linux.dev
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

