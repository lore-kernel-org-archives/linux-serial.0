From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: implement put_char() in cdc-acm
Date: Sun, 1 Nov 2015 14:59:21 -0500
Message-ID: <56366F19.90202@hurleysoftware.com>
References: <1445958479.2043.6.camel@suse.com>
 <562F9C08.6050105@svenbrauch.de> <1446030280.15140.10.camel@suse.com>
 <5630BE5E.6040204@hurleysoftware.com> <1446035622.15140.17.camel@suse.com>
 <563667D9.9080401@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <563667D9.9080401-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Brauch <mail-ITmcY+a7/CDoK6nBLMlh1Q@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 11/01/2015 02:28 PM, Sven Brauch wrote:
> Hey,
>
> On 28/10/15 13:33, Oliver Neukum wrote:
>>> Sven, please test Oliver's patch on that tree.
>> It can be found at
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/gregkh/tty/
> I finally got around to test this; sorry for the delay.
>
> I cloned that tree (git describe said v4.3-rc5), and applied Oliver's
> patch. With that kernel booted, the error occured much less frequently,
> but was still reproducable under load. With 4.2.5, I get a failure after
> a few hundred MB; with 4.3-rc5 plus patch, it transferred serveral gigabytes
> without errors, but failed when I started compiling something in the
> background as a test.
>
> So, I guess, this improves things but there's still no guarantee that
> the data sent by the device will actually be delivered.
>
> Querying for the stty options while the program is running gives this:
> # sudo stty -a -F /dev/ttyACM0
> speed 9600 baud; rows 0; columns 0; line = 0;
> intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W; lnext = ^V; discard = ^O;
> min = 0; time = 0;
> -parenb -parodd -cmspar cs8 hupcl -cstopb cread clocal -crtscts
> -ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr -icrnl -ixon -ixoff -iuclc -ixany -imaxbel -iutf8
> -opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
> -isig -icanon -iexten -echo -echoe -echok -echonl -noflsh -xcase -tostop -echoprt -echoctl -echoke -extproc
>
> If there's anything else which would be helpful for you to have tested,
> please let me know.

Just the kernel .config of the host please.

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
