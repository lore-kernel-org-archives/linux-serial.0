From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 2/2] kgdboc: Change printk to the right fashion
Date: Tue, 14 Aug 2018 14:35:36 +0100
Message-ID: <20180814133536.bfpygzwnmlqfsee5@holly.lan>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
 <1534250761-824-2-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534250761-824-2-git-send-email-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhe.he@windriver.com
Cc: jason.wessel@windriver.com, gregkh@linuxfoundation.org, jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 14, 2018 at 08:46:01PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> pr_* is preferred according to scripts/checkpatch.pl.
> 
> Cc: stable@vger.kernel.org

This change does not "fix a problem that causes a build error
(but not for things marked CONFIG_BROKEN), an oops, a hang, data
corruption, a real security issue, or some “oh, that’s not good” issue.
In short, something critical.". Only the first patch meets this criteria
and only that patch should be Cc:ed to stable@ .

Please remove from this patch.


> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2:
> - Split printk cleanups into a single patch
> - Add cc to stable@vger.kernel.org
> 
>  drivers/tty/serial/kgdboc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 206f8c2..0003d6c 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -136,7 +136,7 @@ static int kgdboc_option_setup(char *opt)
>  	}
>  
>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("kgdboc: config string too long\n");

Looks like you should remove the tags from pr_err and use pr_fmt(fmt) to
put tags on the messages:

#define pr_fmt(fmt) "kgdboc: " fmt


Daniel.

>  		return -ENOSPC;
>  	}
>  	strcpy(config, opt);
> @@ -253,7 +253,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	int len = strlen(kmessage);
>  
>  	if (len >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("kgdboc: config string too long\n");
>  		return -ENOSPC;
>  	}
>  
> @@ -264,8 +264,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	}
>  
>  	if (kgdb_connected) {
> -		printk(KERN_ERR
> -		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
> +		pr_err("kgdboc: Cannot reconfigure while KGDB is connected.\n");
>  
>  		return -EBUSY;
>  	}
> -- 
> 2.7.4
> 
