Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593183;
	b=Gqy6bdD02xFD4vBqv7irDg3YyFQL6seh+GJcNnGuIp3aOj8l8BXP4AnmWKb//93lF2BA
	 ezTKagolV+mQ98O2du7Fl7u0tqXIrib/n1Ow9PYNs6X9AR18YRwfve1mvUZgAVdNCZ7vo
	 QqxHueFvdpkshgG0PiOFd5ubMCeXaqM4XlmXDbz3/OA5JJHirRI1ZBWN/1hwdxm8GhwgT
	 b6/t0VJtFBVAKASZVaVSRfPcwYcr0I6MoXfLfPRnIqTP4I2iSsIq8Rilm+Poez6c9ZSi6
	 64MNd509CyYwisyMPs3JzbF6/H+1uMq883EX9iwWJmz6IVJ15Dinoaq5QDKEF8t6vzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593183;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kThb887yl4OaivErYCFX9FiyQChfD/n8kNnGpPqyOzY=;
	b=jYJFNVNgGJay+F43iGFojAznFv/JR2QrcpS66Om/Lef/d2dIYAp6FpC7eCosCkBOdseD
	 cTnTpskRLJkHXpobg786deH+mjfwmpZ3vj7Fn8/a5R3H6WVAVEB7NPpAZJJH33PABWE4M
	 gJdTKWOm4m8Be1LhyGsAHSwRfk9sFEqhZ3oMqufUvSL4bqMFkf7UtTVnKD1JloHszzURz
	 DD7yL9BgDyK/oChz51odSYmEkpJT2lg8BdJwqAJh01aJ88NsQUmEX+/zVqjHMnWXF1loL
	 XdVLtoltNps11r6WPShn79d02kOCHbQiow+zbXfjjVr5VdP8pC6DXyrB8TQ2Kp8O0Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSCxxTBw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39A606A319;
	Wed, 21 Oct 2026 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aSCxxTBw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC941F000C5;
	Wed, 21 Oct 2026 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792593182;
	bh=kThb887yl4OaivErYCFX9FiyQChfD/n8kNnGpPqyOzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aSCxxTBwdQ5fBcPY9rOyetmvAKv8H1aMfpdlqo1ahvg7jvA41DV4oAyTeVEJN8l7q
	 BeI7135qFLSfUYbAAv/R1tmN1WE1PYgOLR5EZAFITVLgCYQJP54u+dyIBVpW9PouP5
	 wz++H6El1fqhqn3psexHFsz7He+Nk++0QuaEVrZIgcfqFN1YpFM+QYy/GMfB8WhR40
	 SBMg1uA46xRCRPOE4EIiCwoi1w78JlXG5CcU2q4tLp0/8UNsW2deh/Gu3mPWyQ7TLg
	 cuDTKyPv6Dc8b5VLMpHIbXMcm8Pm7tPTZqq9G7gTQVh0ciXQ7tsXiCA2WsXVm7M+YL
	 7JhqXuotSdbUQ==
Message-ID: <250bded6-2a51-457d-9bf2-24c299dbd7a9@kernel.org>
Date: Wed, 21 Oct 2026 16:32:58 +0200
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] serdev: handle devices without an ACPI or device
 tree node
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, markus.probst@posteo.de,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,
 ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca,
 derekjohn.clark@gmail.com
References: <20261021092124.2306053-1-an.wu@canonical.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261021092124.2306053-1-an.wu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 21-Oct-26 11:21, ChunAn Wu wrote:
> Driver-created serdev clients may lack an ACPI companion or device tree
> node.
> 
> Add a creator-supplied name for these clients. Use it as a serial
> modalias fallback and to match a serdev driver of the same name. Keep
> returning -ENODEV for unnamed clients.
> 
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

For v3 of this series please include a cover-letter and explain
why this series is an improvement over the` existing situation.

The dell-uart-backlight and lenovo-yoga-tab2-pro-1380-fastcharger
drivers are both pretty special cases and here you are adding
a chunk of code to the serdev-core for those special cases,
so I wonder: why?

The current manual attach approach taking in these 2 special
drivers works fine.

What does this new approach gain us ?

Also if you are going to do this may I suggest looking at doing
some sort of of-compatible matching based on a compatible string
inside a swnode ? I do not know what that would look like but
that is something which seems like it might be generally useful
also outside these 2 special cases.

Regards,

Hans



> ---
>  drivers/tty/serdev/core.c | 36 ++++++++++++++++++++++++++++++------
>  include/linux/serdev.h    | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 7500efcdfc21..8354a4688fd8 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -29,13 +29,21 @@ static DEFINE_IDA(ctrl_ida);
>  static ssize_t modalias_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> +	const struct serdev_device *serdev = to_serdev_device(dev);
>  	int len;
>  
>  	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
>  	if (len != -ENODEV)
>  		return len;
>  
> -	return of_device_modalias(dev, buf, PAGE_SIZE);
> +	len = of_device_modalias(dev, buf, PAGE_SIZE);
> +	if (len != -ENODEV)
> +		return len;
> +
> +	if (!serdev->name[0])
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->name);
>  }
>  static DEVICE_ATTR_RO(modalias);
>  
> @@ -47,15 +55,22 @@ ATTRIBUTE_GROUPS(serdev_device);
>  
>  static int serdev_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  {
> +	const struct serdev_device *serdev = to_serdev_device(dev);
>  	int rc;
>  
> -	/* TODO: platform modalias */
> -
>  	rc = acpi_device_uevent_modalias(dev, env);
>  	if (rc != -ENODEV)
>  		return rc;
>  
> -	return of_device_uevent_modalias(dev, env);
> +	rc = of_device_uevent_modalias(dev, env);
> +	if (rc != -ENODEV)
> +		return rc;
> +
> +	if (!serdev->name[0])
> +		return -ENODEV;
> +
> +	add_uevent_var(env, "MODALIAS=%s%s", SERDEV_MODULE_PREFIX, serdev->name);
> +	return 0;
>  }
>  
>  static void serdev_device_release(struct device *dev)
> @@ -88,14 +103,23 @@ static const struct device_type serdev_ctrl_type = {
>  
>  static int serdev_device_match(struct device *dev, const struct device_driver *drv)
>  {
> +	const struct serdev_device *serdev;
> +
>  	if (!is_serdev_device(dev))
>  		return 0;
>  
> -	/* TODO: platform matching */
>  	if (acpi_driver_match_device(dev, drv))
>  		return 1;
>  
> -	return of_driver_match_device(dev, drv);
> +	if (of_driver_match_device(dev, drv))
> +		return 1;
> +
> +	/* Fall back to the name set by the creator of the device */
> +	serdev = to_serdev_device(dev);
> +	if (!serdev->name[0])
> +		return 0;
> +
> +	return strcmp(serdev->name, drv->name) == 0;
>  }
>  
>  /**
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index b6c3d957ec15..26baa0321eef 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -8,6 +8,7 @@
>  #include <linux/types.h>
>  #include <linux/device.h>
>  #include <linux/iopoll.h>
> +#include <linux/string.h>
>  #include <linux/uaccess.h>
>  #include <linux/termios.h>
>  #include <linux/delay.h>
> @@ -19,6 +20,10 @@ struct serdev_device;
>   * serdev device structures
>   */
>  
> +/* Large enough to hold the KBUILD_MODNAME of any serdev client driver */
> +#define SERDEV_NAME_SIZE	40
> +#define SERDEV_MODULE_PREFIX	"serial:"
> +
>  /**
>   * struct serdev_device_ops - Callback operations for a serdev device
>   * @receive_buf:	Function called with data received from device;
> @@ -35,6 +40,9 @@ struct serdev_device_ops {
>   * struct serdev_device - Basic representation of an serdev device
>   * @dev:	Driver model representation of the device.
>   * @nr:		Device number on serdev bus.
> + * @name:	Name of the device, set by its creator, empty for devices
> + *		which are enumerated from firmware, see
> + *		serdev_device_set_name().
>   * @ctrl:	serdev controller managing this device.
>   * @ops:	Device operations.
>   * @write_comp:	Completion used by serdev_device_write() internally
> @@ -43,6 +51,7 @@ struct serdev_device_ops {
>  struct serdev_device {
>  	struct device dev;
>  	int nr;
> +	char name[SERDEV_NAME_SIZE];
>  	struct serdev_controller *ctrl;
>  	const struct serdev_device_ops *ops;
>  	struct completion write_comp;
> @@ -135,6 +144,28 @@ static inline void serdev_device_set_client_ops(struct serdev_device *serdev,
>  	serdev->ops = ops;
>  }
>  
> +/**
> + * serdev_device_set_name() - set the name of a serdev device
> + * @serdev:	serdev device.
> + * @name:	non-empty name to use, typically KBUILD_MODNAME of the client
> + *		driver.
> + *
> + * A serdev device is identified by its ACPI companion, by its device tree
> + * node, or by a name set by its creator. Serdev devices which are
> + * instantiated by a driver rather than by firmware have neither of the
> + * former, so they must set a name before serdev_device_add() to be
> + * identifiable. Doing so gives them a SERDEV_MODULE_PREFIX modalias and
> + * makes them match a serdev device driver of the same name.
> + *
> + * Devices enumerated from firmware have no name and keep deriving their
> + * modalias and their driver match from firmware only.
> + */
> +static inline void serdev_device_set_name(struct serdev_device *serdev,
> +					  const char *name)
> +{
> +	strscpy(serdev->name, name);
> +}
> +
>  static inline
>  void *serdev_controller_get_drvdata(const struct serdev_controller *ctrl)
>  {
> 
> base-commit: 9e947d96915af63e28896caae85a81b74855621b

