From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v1 1/2] drivers: jtag: Add JTAG core driver
Date: Wed, 2 Aug 2017 17:37:03 +0200
Message-ID: <CAK8P3a1tEcDV2yTJoWcKwoM1=+NS0AgyckHappSGN5aCajkkeQ@mail.gmail.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com> <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, mec@shout.net, vadimp@maellanox.com, system-sw-low-level@mellanox.com, Jiri Pirko <jiri@mellanox.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 2, 2017 at 3:18 PM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:

> +
> +static void *jtag_copy_from_user(void __user *udata, unsigned long bit_size)
> +{
> +       void *kdata;
> +       unsigned long size;
> +       unsigned long err;
> +
> +       size = DIV_ROUND_UP(bit_size, BITS_PER_BYTE);
> +       kdata = kzalloc(size, GFP_KERNEL);
> +       if (!kdata)
> +               return NULL;
> +
> +       err = copy_from_user(kdata, udata, size);
> +       if (!err)
> +               return kdata;
> +
> +       kfree(kdata);
> +       return NULL;
> +}

You can use memdup_user() here to simplify this, or just change the callers
to use that directly.

> +static long jtag_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       struct jtag *jtag = file->private_data;
> +       struct jtag_run_test_idle idle;
> +       struct jtag_xfer xfer;
> +       void *user_tdio_data;
> +       unsigned long value;
> +       int err;
> +
> +       switch (cmd) {
> +       case JTAG_GIOCFREQ:
> +               if (jtag->ops->freq_get)
> +                       err = jtag->ops->freq_get(jtag, &value);
> +               else
> +                       err = -EOPNOTSUPP;
> +               if (err)
> +                       break;
> +
> +               err = __put_user(value, (unsigned long __user *)arg);
> +               break;

Use put_user() instead of __put_user() everywhere please.

To avoid using so many casts, just use a temporary variable
that holds the pointer.

Also, you should never use 'unsigned long' pointers in the arguments,
use either '__u32' or '__u64', whichever makes more sense here.

I see that your command definition has 'unsigned int', so it's already
broken on 64-bit architectures.

> +       case JTAG_IOCXFER:
> +               if (copy_from_user(&xfer, (void __user *)arg,
> +                                  sizeof(struct jtag_xfer)))
> +                       return -EFAULT;
> +
> +               user_tdio_data = xfer.tdio;
> +               xfer.tdio = jtag_copy_from_user((void __user *)user_tdio_data,
> +                               xfer.length);
> +               if (!xfer.tdio)
> +                       return -ENOMEM;

You should enforce an upper bound for the length here,
to prevent users from draining kernel memory with giant
buffers.

> +static struct jtag *jtag_get_dev(int id)
> +{
> +       struct jtag *jtag;
> +
> +       mutex_lock(&jtag_mutex);
> +       list_for_each_entry(jtag, &jtag_list, list) {
> +               if (jtag->id == id)
> +                       goto found;
> +       }
> +       jtag = NULL;
> +found:
> +       mutex_unlock(&jtag_mutex);
> +       return jtag;
> +}

I'm pretty sure there is a better way to look up the data from the
chardev inode,
though I now forget how that is best done.

> +static const struct file_operations jtag_fops = {
> +       .owner          = THIS_MODULE,
> +       .llseek         = no_llseek,
> +       .unlocked_ioctl = jtag_ioctl,
> +       .open           = jtag_open,
> +       .release        = jtag_release,
> +};

add a compat_ioctl pointer here, after ensuring that all ioctl commands
are compatible between 32-bit and 64-bit user space.

In turn, no_llseek is the default, you can drop that.

> +struct jtag *jtag_alloc(size_t priv_size, const struct jtag_ops *ops)
> +{
> +       struct jtag *jtag = kzalloc(sizeof(*jtag) + priv_size, GFP_KERNEL);
> +
> +       if (!jtag)
> +               return NULL;
> +
> +       jtag->ops = ops;
> +       return jtag;
> +}
> +EXPORT_SYMBOL_GPL(jtag_alloc);

Please add some padding behind 'struct jtag' to ensure
the private data is aligned to ARCH_DMA_MINALIGN,

      Arnd
