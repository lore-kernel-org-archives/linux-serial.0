Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87E1946C7;
	Mon, 12 Aug 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495235; cv=none; b=J5nnDGW5dbjdIjfQFbIXl5C/oFDrI1bzLzCbwBHkNPRHamsSlTgnukQXxtAZFL/0T2Inas5DvpB6a2PkPZgbj+RsJB/qbOHp7H2AW09j71PkX+Z1oWd+wKevi5Yv6FCMdDWLcT8hNoX6dtcfXvsbaktAJ16bZnZZFkVpnAR9gYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495235; c=relaxed/simple;
	bh=gqSwB3JabRnTBWr9mDOnoHCcTjPli/nHwfQwHBVTRFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPqgkN7XIVHFl9lwlZ8FX8NXi0oq6ygo1q/nnYEuO5BuzYCmM1ozEFN6dYQONso1nVmC3lSUNVAO+Zy5TIpqSIRPh+6a6mu6MWfKPWqtHTU/VlwNjUIiEWW7Kx697Hh08K+az5wFwMHzeP0JMLhW8TAAnEC3F1eWeBZgdhAAMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=HLPqRBq8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="HLPqRBq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1723495217; x=1724100017; i=wahrenst@gmx.net;
	bh=wecr4sBy4vz3X+K9p7gOFWA14z8qJG/JWx3qpiWU3L8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HLPqRBq8nSlfS1X/mVII7EYm5WEblbN/SgB5gN+F/lblcr+CHQ7AWn88EzX5ESHC
	 ASF1Xnvcycv9HTcjcTcKeCTKwaRBNW7ffWdQf19hdN3IqFfKETiVdgqMFCgQPLrb7
	 hOnx2JEUAWuNbettnCUveWIJpTlaCop9f90T4e2uL+r01x7VECWXtY3xByQkumWoL
	 ZfqzDl6UDGE+uOGrVZxZQQBjU8zY78C8zmJMS54uDV2uu1rxB9h+7AW+pML4b6TGv
	 JEXPSauHTWq2aAebql9Ng+SOJ9VfG6sXdSychEAP63JD8G1dGEL5ZSpdh8knlRK7a
	 06flwmesatBU4ZSWaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1sk7A114I4-00UXXx; Mon, 12
 Aug 2024 22:40:17 +0200
Message-ID: <ad11903f-7ded-492f-a680-3ddcfcc7e0b6@gmx.net>
Date: Mon, 12 Aug 2024 22:40:15 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] serial: 8250_bcm2835aux: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <20240812143514.953612-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240812143514.953612-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vj49RLtOXMh9VjzIZ/X+tiPKrni3n148+Wbyzg+q9bPGDEhERKZ
 soeOiGBKec4RyWCzVH3k+7v/Bf7G/jFFLH6VPvMkJENf2BsvOVeZRh2dzQaWgB0ZApbdhQ9
 v053/1hNqPnHWSNuBM0cNkeUPnzjbW90xDQoTu4WZ8CArow6oR6vG8SdAQxqCcArbji91CG
 Q4ccmWui35qHIB92VULOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+UIjASP9P4w=;23tucjNCnFxLaZNqtALbFMs4bJS
 g2stW2NdTrMv6CXqXGhzBc0poYkbqwmHjCXUiEBoMeVQzWuP4y9QcZF5V9VrQEexgElKFUpYQ
 oNFMLHJoKQoD9UBlIb5gQbf1sZADp4KTWjSzy+/zFLkQg38RHWGnmWfnxAJ/dOIrAlpNT6Pkr
 mHxssjyge6oVUbZBqvOtElRNMVD+veEZFB3JpMuhgDzpBhzuo5al/T6peGOZKhiZB4Dsvjcmo
 asQjX9VtwVHxICdnXhvwnjUyN6DYTkDM30Yj5NpizEgSitxv8uCXLJG28AqtgWDzmEjjRxrkG
 bAbaSWUd6cI1tlbNTj/75TJT9wLGCEEwXK3hndHeb2XpnuytF5s0pKdCrf3kYIC9CVQs8S2Oc
 qD/vXbn2eFoOHye0LCrPg0JTHk0wA/bi4Y/0FA7Nu1cBHu1X+HOv6ftIitkXGcti2IhnyfuYw
 TM2SDzUAYo/9UxaiZ2GzmL/kzJQg8o6m358hJPgFj6AbtdOq7bZjzx8aPP+myUJf0LQUqIgpm
 6nF5DmHW4Y8UEZyE4oOrsrKrptQJOs5MKHqx8kkp0clVQqWtqp4dVFwu2tAQaXxCHGyCQJ1Ls
 unzcsfBJWvhHVDlYqNskWvVm1dOc5qBeKbHPV0Eqtqs0VoDW1xlnzXyVvIham1t5UmyNtOVA/
 uPfg03kypHXlRhtaki0IuhQLgAurPAVYGTxG2ylW0F+5UEGHESjIKydL73yhheMJByl17AJ2u
 6PqWBVvzufU3Mjk/xiSvsWWqRso7q+CB9iFIP1IKhgguWso9ygDSLpT4wz2o+9ObzlnsNfYhn
 nDDaZswfCoeG+XgxloAtewBg==

Hi Andy,

Am 12.08.24 um 16:35 schrieb Andy Shevchenko:
> The SIMPLE_DEV_PM_OPS() is deprecated, replace it with the
> DEFINE_SIMPLE_DEV_PM_OPS() for setting the driver's PM routines.
it's possible the implementation doesn't use the optimal macros here.
But this sentence is a little bit confusing to me, because the code
doesn't use SIMPLE_DEV_PM_OPS().

Best regards
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_bcm2835aux.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/ser=
ial/8250/8250_bcm2835aux.c
> index 36e2bb34d82b..829abef2564d 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -245,9 +245,7 @@ static int bcm2835aux_resume(struct device *dev)
>   	return 0;
>   }
>
> -static const struct dev_pm_ops bcm2835aux_dev_pm_ops =3D {
> -	SYSTEM_SLEEP_PM_OPS(bcm2835aux_suspend, bcm2835aux_resume)
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(bcm2835aux_dev_pm_ops, bcm2835aux_suspe=
nd, bcm2835aux_resume);
>
>   static struct platform_driver bcm2835aux_serial_driver =3D {
>   	.driver =3D {

