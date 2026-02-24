Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811F37B3F0
	for <linux-serial@vger.kernel.org>; Tue, 24 Feb 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930478; cv=none; b=JW9xinzrRKiyZ1TMuJ44cA292Q+bJT4J2yMDaeOXgfNtfT23GKmqvcYqQUHkBH/QT+Sw8k+buP0I3bAHohK0sQ/D7KUuc3j9TV0KQZ/nCAe/JPzoie8ecYq1LXY8ZcgS/uR4pSpLMuEJFIl36JxQ3V+edE79xWGcocj41icKXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930478; c=relaxed/simple;
	bh=Ar8h4pwA1NDtg967Id6YIJ0hbFJ+kyEH685q68t02QU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRG9b8VveOF7j5QAo2YC0bbI517qUGLXUmmj8KTNwXICOwW8HF/x270ttox3iRh6tHseiCqd+Ht33G8pDyl5zLtDp0YBw98TY3ZgvfQ6PbQFnDh14PWlAIg6uRGITgwh9r2x6UNjmxIrOnBjITAmwC2BKM/yeKUEPw2UttdYDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+0wMxvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+0wMxvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD7BC2BC87
	for <linux-serial@vger.kernel.org>; Tue, 24 Feb 2026 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771930478;
	bh=Ar8h4pwA1NDtg967Id6YIJ0hbFJ+kyEH685q68t02QU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=c+0wMxvVDXZxZHmcK9n5s+b+eQhUfRgsCmIoV+B66WGCbkKM7bWxasW4YO/qiPCxl
	 Cn4PjqZt7MbRIRAcIzH29o6h1NP/zsXuAT4xsaIS2TsQHrRmY7nU5F1fR5RdyQ2pRW
	 i0h2XB9LlnNM6CK8z9foLFA/nAgMG1DqxBkN9qFDwx9zupKeeb86HGA3pUnlM0L5zO
	 DtkNVDbR2CBxMAWqAisNBVUaT64G2XPQYQgfNE7YldOjFY6lGvvSTPK5tBDVZcw6FI
	 dRWzmlgOA5JUp6Xa2lxKQ2kYp8m3Q1mQLt8VEbV6ulZK7SToUFDsfGK7j2S4svfif5
	 bAQmqnirYSvMg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38708180241so41855951fa.1
        for <linux-serial@vger.kernel.org>; Tue, 24 Feb 2026 02:54:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuBhH+uJFf1EEXrrwYHtd+YchcrLfLJ5LMVQjdFlhAgx6sZFxAC8D+WH+60TqUy/7bUCJ81zZilCpz0LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYMijMHM9ioS1BHSB7fp4oSwlu6sU0MIKZBLkfa+7Odr+bNyVY
	qms3xjCDnkLq/Q+/zn83hU8EwcUxhjIwLEsP72kKzB3DmpE4nFJwET8+Ldz43tiroKbhtPE3dpp
	e1yF0sdZMTJOsN/lwZHA/ERPcvXaJhKhxFdZSpXMEtA==
X-Received: by 2002:a05:651c:1602:b0:385:beca:f6d2 with SMTP id
 38308e7fff4ca-389a5c92b9bmr38250061fa.1.1771930475771; Tue, 24 Feb 2026
 02:54:35 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 04:54:34 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 04:54:34 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aZ19kFCv_3QUkvPL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
 <20260224-pci-m2-e-v5-2-dd9b9501d33c@oss.qualcomm.com> <CAMRc=MethnZu_GrujadpBZwj4SpgdNXEnTfEikSvPkO2f9MJjg@mail.gmail.com>
 <aZ19kFCv_3QUkvPL@smile.fi.intel.com>
Date: Tue, 24 Feb 2026 04:54:34 -0600
X-Gmail-Original-Message-ID: <CAMRc=Md5K=qPbbjSX6eX7EUwgPHpPkUhOPF7RsqD5gejXK2rnQ@mail.gmail.com>
X-Gm-Features: AaiRm50PZNtQU10kvSbt1uPfme98Sm6BHfpF2pr5K4ZzyNi38Xb-W4BKtnbBLf4
Message-ID: <CAMRc=Md5K=qPbbjSX6eX7EUwgPHpPkUhOPF7RsqD5gejXK2rnQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Feb 2026 11:29:36 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Tue, Feb 24, 2026 at 02:16:17AM -0800, Bartosz Golaszewski wrote:
>> On Tue, 24 Feb 2026 06:30:48 +0100, Manivannan Sadhasivam via B4 Relay
>> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
>> >
>> > Add of_find_serdev_controller_by_node() API to find the serdev controller
>> > device associated with the devicetree node.
>
> ...
>
>> > +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
>> > +{
>> > +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
>> > +
>> > +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
>> > +}
>> > +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
>>
>> I'm not sure if I commented on it before but there's no reason for this to be
>> OF-centric. It would work equally well as (I think the same should keep the
>> "serdev" prefix too for correct namespacing):
>>
>> struct serdev_controller *serdev_find_controller_by_fwnode(struct
>> fwnode_handle *fwnode)
>> {
>> 	struct device *dev = bus_find_device_by_fwnode();
>>
>> 	...
>> }
>>
>> It would be more flexible and users can always use to_of_node().
>
> IIRC it was discussed already and the fact of use only in DT overlays and
> absence of the user for all this time makes it feel like solving non-existing
> problem. So OF-centric in this case seems to be fine.
>

Ok then.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
