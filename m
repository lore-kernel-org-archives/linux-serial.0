From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 05/10] fblog: add framebuffer helpers
Date: Mon, 18 Jun 2012 20:50:12 +0200
Message-ID: <CANq1E4RZoxUFJ+Ofx_MVu8xBvRdsS2kmBusKWEitEjPBwukpkA@mail.gmail.com>
References: <1339884266-9201-1-git-send-email-dh.herrmann@googlemail.com>
	<1339884266-9201-6-git-send-email-dh.herrmann@googlemail.com>
	<20120617003334.765f6226@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120617003334.765f6226@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-serial@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Bruno

On Sun, Jun 17, 2012 at 12:33 AM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> On Sun, 17 June 2012 David Herrmann <dh.herrmann@googlemail.com> wrot=
e:
>> These helpers scan the system for all available framebuffers and reg=
ister
>> or unregister them. This is needed during startup and stopping fblog=
 so we
>> are aware of all connected displays.
>>
>> The third helper handles mode changes by rescanning the mode and adj=
usting
>> the buffer size.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> ---
>> =A0drivers/video/console/fblog.c | =A0 29 ++++++++++++++++++++++++++=
+++
>> =A01 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/video/console/fblog.c b/drivers/video/console/f=
blog.c
>> index e790971..7d4032e 100644
>> --- a/drivers/video/console/fblog.c
>> +++ b/drivers/video/console/fblog.c
>> @@ -399,6 +399,35 @@ static void fblog_unregister(struct fblog_fb *f=
b)
>> =A0 =A0 =A0 kfree(fb);
>> =A0}
>>
>> +static void fblog_register_all(void)
>> +{
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < FB_MAX; ++i)
>> + =A0 =A0 =A0 =A0 =A0 =A0 fblog_register(registered_fb[i]);
>
> You should take registration_lock mutex for accessing registered_fb[]=
,
> even better would be to make use of get_fb_info() and put_fb_info()

Indeed, I will change it to use get_fb_info()/put_fb_info().

Btw., is it safe to call console_lock() during
=46B_EVENT_FB_(UN)REGISTERED? I definitely need the console lock when
calling fblog_register() but I am not sure whether all fb-drivers lock
the console during "(un)register_framebuffer()". Otherwise, I would
have to avoid redrawing the console inside of fblog_register().

>> +}
>> +
>> +static void fblog_unregister_all(void)
>> +{
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < FB_MAX; ++i)
>> + =A0 =A0 =A0 =A0 =A0 =A0 fblog_unregister(fblog_info2fb(registered_=
fb[i]));
>
> Same here.
>
> Though for unregistering I'm wondering why you still scan through
> registered_fb[], you should just scan your fblog_fbs[] array!

Oops, you're right. I will change it.

> But here again, make sure to have proper locking to not get races wit=
h
> registration of new framebuffers or removal of existing ones via
> notifications.
>
>> +}
>> +
>> +static void fblog_refresh(struct fblog_fb *fb)
>> +{
>> + =A0 =A0 unsigned int width, height;
>> +
>> + =A0 =A0 if (!fb || !fb->font)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 width =3D fb->info->var.xres / fb->font->width;
>> + =A0 =A0 height =3D fb->info->var.yres / fb->font->height;
>> + =A0 =A0 fblog_buf_resize(&fb->buf, width, height);
>> + =A0 =A0 fblog_redraw(fb);
>> +}
>> +
>
> All these new functions are still unused, for easier following of you=
r
> patch series it would be nice to have them connected when they are
> introduced as otherwise on has to search all following patches for
> finding possible users.

I have to admit the split was crap. I am sorry. I will recreate the
patchset with a proper split. Thanks!

>> =A0static int __init fblog_init(void)
>> =A0{
>> =A0 =A0 =A0 return 0;
>
> Bruno

Thanks for reviewing, regards
David
