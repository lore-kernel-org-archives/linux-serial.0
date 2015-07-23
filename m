From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] Avoid usb reset crashes by making tty_io cdevs truly
 dynamic
Date: Thu, 23 Jul 2015 15:08:54 -0700
Message-ID: <20150723220854.GA24492@kroah.com>
References: <555B518D.2010102@kynesim.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <555B518D.2010102@kynesim.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Watts <rrw@kynesim.co.uk>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 19, 2015 at 04:06:53PM +0100, Richard Watts wrote:
> Avoid usb reset crashes by making tty_io cdevs truly dynamic

What USB reset crashes are you referring to here?

> 
> Signed-off-by: Richard Watts <rrw@kynesim.co.uk>
> Reported-by: Duncan Mackintosh <DMackintosh@cbnl.com>
> ---
>  drivers/tty/tty_io.c       | 24 ++++++++++++++++--------
>  include/linux/tty_driver.h |  2 +-
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e569546..699cf20 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3168,9 +3168,12 @@ static int tty_cdev_add(struct tty_driver *driver,
> dev_t dev,
>  		unsigned int index, unsigned int count)
>  {
>  	/* init here, since reused cdevs cause crashes */
> -	cdev_init(&driver->cdevs[index], &tty_fops);
> -	driver->cdevs[index].owner = driver->owner;
> -	return cdev_add(&driver->cdevs[index], dev, count);
> +	driver->cdevs[index] = cdev_alloc();
> +	if (!driver->cdevs[index])
> +		return -ENOMEM;
> +	cdev_init(driver->cdevs[index], &tty_fops);
> +	driver->cdevs[index]->owner = driver->owner;
> +	return cdev_add(driver->cdevs[index], dev, count);
>  }
> 
>  /**
> @@ -3276,8 +3279,10 @@ struct device *tty_register_device_attr(struct
> tty_driver *driver,
> 
>  error:
>  	put_device(dev);
> -	if (cdev)
> -		cdev_del(&driver->cdevs[index]);
> +	if (cdev) {
> +		cdev_del(driver->cdevs[index]);
> +		driver->cdevs[index] = NULL;
> +	}
>  	return ERR_PTR(retval);
>  }
>  EXPORT_SYMBOL_GPL(tty_register_device_attr);
> @@ -3297,8 +3302,10 @@ void tty_unregister_device(struct tty_driver *driver,
> unsigned index)
>  {
>  	device_destroy(tty_class,
>  		MKDEV(driver->major, driver->minor_start) + index);
> -	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC))
> -		cdev_del(&driver->cdevs[index]);
> +	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
> +		cdev_del(driver->cdevs[index]);
> +		driver->cdevs[index] = NULL;
> +	}
>  }
>  EXPORT_SYMBOL(tty_unregister_device);
> 
> @@ -3363,6 +3370,7 @@ err_free_all:
>  	kfree(driver->ports);
>  	kfree(driver->ttys);
>  	kfree(driver->termios);
> +	kfree(driver->cdevs);
>  	kfree(driver);
>  	return ERR_PTR(err);
>  }
> @@ -3391,7 +3399,7 @@ static void destruct_tty_driver(struct kref *kref)
>  		}
>  		proc_tty_unregister_driver(driver);
>  		if (driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)
> -			cdev_del(&driver->cdevs[0]);
> +			cdev_del(driver->cdevs[0]);
>  	}
>  	kfree(driver->cdevs);
>  	kfree(driver->ports);
> diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
> index 92e337c..1610524 100644
> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -296,7 +296,7 @@ struct tty_operations {
>  struct tty_driver {
>  	int	magic;		/* magic number for this structure */
>  	struct kref kref;	/* Reference management */
> -	struct cdev *cdevs;
> +	struct cdev **cdevs;
>  	struct module	*owner;
>  	const char	*driver_name;
>  	const char	*name;

I don't understand what bug this patch is trying to solve, care to help
describe it better?

thanks,

greg k-h
