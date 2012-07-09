From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH v2 04/11] fbdev: export get_fb_info()/put_fb_info()
Date: Mon, 9 Jul 2012 19:34:44 +0200
Message-ID: <CANq1E4S-7LVw-CoD=nvn3npffSZgw9V3Ec9x3XGt-j3ps5-XPA@mail.gmail.com>
References: <1341784614-2797-1-git-send-email-dh.herrmann@googlemail.com>
	<1341784614-2797-5-git-send-email-dh.herrmann@googlemail.com>
	<CAMuHMdWsSqMjqDuE_qgNUjc1eCWZqLLo1GNxwLYZNih=YBFh0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWsSqMjqDuE_qgNUjc1eCWZqLLo1GNxwLYZNih=YBFh0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, florianschandinat@gmx.de, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, alan@lxorguk.ukuu.org.uk, bonbons@linux-vserver.org
List-Id: linux-serial@vger.kernel.org

Hi Geert

On Mon, Jul 9, 2012 at 9:34 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, Jul 8, 2012 at 11:56 PM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
>> --- a/drivers/video/fbmem.c
>> +++ b/drivers/video/fbmem.c
>> @@ -46,7 +46,7 @@ static DEFINE_MUTEX(registration_lock);
>>  struct fb_info *registered_fb[FB_MAX] __read_mostly;
>>  int num_registered_fb __read_mostly;
>>
>> -static struct fb_info *get_fb_info(unsigned int idx)
>> +struct fb_info *get_fb_info(unsigned int idx)
>>  {
>>         struct fb_info *fb_info;
>>
>> @@ -61,14 +61,16 @@ static struct fb_info *get_fb_info(unsigned int idx)
>>
>>         return fb_info;
>>  }
>> +EXPORT_SYMBOL(get_fb_info);
>
> EXPORT_SYMBOL_GPL?

Thanks, that seems more appropriate here. I've fixed it.

>> -static void put_fb_info(struct fb_info *fb_info)
>> +void put_fb_info(struct fb_info *fb_info)
>>  {
>>         if (!atomic_dec_and_test(&fb_info->count))
>>                 return;
>>         if (fb_info->fbops->fb_destroy)
>>                 fb_info->fbops->fb_destroy(fb_info);
>>  }
>> +EXPORT_SYMBOL(put_fb_info);
>
> EXPORT_SYMBOL_GPL?

Thanks
David
