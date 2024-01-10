Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAEB4EB23
	for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUiyZqNg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336c5b5c163so2783246f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jan 2024 12:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704917977; x=1705522777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4Y5idhJN/b2YA/7tKi246i77Vd1olII45Is7/rbOJ0=;
        b=iUiyZqNgCnFkVto3hQiKF8VyOixXcMQPDYSayqSXXz9gCSepPHH2O9AO6sKb6iAOZH
         gGm792ekOZKOQ+3ThkQS4eVNh5QGy8+yopc6EKkqsE2BjSXnPi1E+vxp/ErE99BW0GUa
         k5GSUkKUEBWbt9F6C/xLO41qhzIY9NkDtRGLicIEY/3p77ZJPdX7EGsqM+wA7Azqehoj
         DhP3fIvLdBJvaoyX0OTTXXDUuYIbgfL47vzoTDThaJPaOYjI/mzOQ4zuokneJQHFoCMa
         xdrIlVvgRln6IOMxuX0UDHcnw8YudZvooEN6rwY/HE425OjErwJO5wwnYJkk7yxxyTKx
         vxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704917977; x=1705522777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4Y5idhJN/b2YA/7tKi246i77Vd1olII45Is7/rbOJ0=;
        b=hHv+8yeBGQC11loHALV0LP28Iv1F2Fwev/hD+Vz+BgDHmKv679mnzrLxNDhppvwN4e
         QWwv3IX/fAmAa05ezTCq85wmHOaN2Cw4hlr/gEFbvvEO0rRtAOZsDE0inIHJxLO7XGgz
         ZLKL2Gt124uDBm4Ecjaa7FkjIOSRKvzQp/Zw3NH6723l2QetEnBuc31zIeQzfVWbmttU
         h0Eo4A95q3yvRxzw5/JwgfOtcKuf+UnQe/4Nu4BygN8jrvGRotJqN0rrFWuXkYMXeBoD
         nWJ985VIMMdb/GLl/MGBe0lhvBav185HGKYscS44l4thlbrsCnCAtE1qehmWDkzD5JbI
         389g==
X-Gm-Message-State: AOJu0YziqQY/2q4Jz/PFzf+KjL8cF8Pf5f0FSHSI54M8RkCg2Crk3w51
	QOcWJBhxAkyImERULE/DJsx6tsEaKDrEfQ==
X-Google-Smtp-Source: AGHT+IG3HiAJlzmqFtXtKgjd2ICz2/cUda1a20KPRN8RDLfnmQlfE0i2/PldCAJPpMqIQtYSd6VysQ==
X-Received: by 2002:adf:fc90:0:b0:336:9ab3:dc47 with SMTP id g16-20020adffc90000000b003369ab3dc47mr8037wrr.42.1704917976732;
        Wed, 10 Jan 2024 12:19:36 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d46c8000000b003372befd19bsm5636334wrs.104.2024.01.10.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:19:36 -0800 (PST)
Date: Wed, 10 Jan 2024 23:19:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Rengarajan S <rengarajan.s@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pci1xxxx: fix off by one in
 pci1xxxx_process_read_data()
Message-ID: <05465217-174e-4888-a6ab-6251f4a9920b@moroto.mountain>
References: <ZZ7vIfj7Jgh-pJn8@moroto>
 <20240110144605.2a8813d4bfaff1a55edb9938@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110144605.2a8813d4bfaff1a55edb9938@hugovil.com>

On Wed, Jan 10, 2024 at 02:46:05PM -0500, Hugo Villeneuve wrote:
> Hi,
> it is not simply a matter of adding "fix" to the title.
> 
> You must explain what and why vs. how.
> 
> Please see:
>   https://cbea.ms/git-commit/#why-not-how
> 
> for some guidelines on writing a good commit message.
> 

If you can't understand why a buffer overflow is bad then I honestly
don't know what to say...

When I was a newbie, I encountered a driver which was written in
terrible style.  And I thought why do people allow it???  This is
garbage and it's messing up the Linux kernel with its bad style.

But after I got older, I realized that he was the only person with that
hardware and the only person who cared about it.   If I started fighting
with him about style then he would leave.  He was a quirky guy with bad
taste but he was still making useful contributions so it was better to
tolerate him.

These days I'm the old quirky guy.  If you want to fight with me about
commit messages, that's fine.  I can easily just add you to my list of
subsystems which only receive bug reports instead of patches.  (I think
only BPF is on the list currently because it's annoying to track the
bpf vs bpf-next tree).

Feel free to re-write this patch however you want and give me
Reported-by credit.

regards,
dan carpenter

