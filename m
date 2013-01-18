From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: Switch to using struct tty_port
Date: Fri, 18 Jan 2013 21:19:28 +0530
Message-ID: <50F96F08.7090705@nvidia.com>
References: <1358429505-31746-1-git-send-email-thierry.reding@avionic-design.de> <50F82FE7.9090403@wwwdotorg.org> <20130118083756.GA3303@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130118083756.GA3303-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Friday 18 January 2013 02:07 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Thu, Jan 17, 2013 at 10:07:51AM -0700, Stephen Warren wrote:
>> On 01/17/2013 06:31 AM, Thierry Reding wrote:
>>> Many of the tty functions were converted to use a struct tty_port
>>> instead of a struct tty_struct. Update the Tegra driver accordingly to
>>> avoid build breakage.
>> I tested that this does indeed fix the build warnings. I didn't test the
>> resultant driver.
> I wonder if this would have been caught earlier if it had errored out
> instead of outputting lots of warnings. Looking at the gcc documentation
> there doesn't seem to be a way to turn this kind of warning into an
> error. That would leave -Werror as the only option to have the compiler
> abort on this kind of warning.
>
> Globally enabling -Werror might not be a good idea and I'm sure it must
> have been discussed in the past (even though Google doesn't show any
> references). In this particular case the warnings are actually severe
> errors and are very likely to cause buggy behaviour so it would be good
> to catch them at compile time. Warnings are unfortunately quite easy to
> ignore.
>
> I know I can always use EXTRA_CFLAGS to change this for local builds,
> but maybe getting more people to do this would be worthwhile.
>

There was no issue when patch created. The change happen in the api with 
same time when patch created and so become out of sync.

API changed with commit on 1/16. Serial driver also get added on 1/16.

Author: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>  2013-01-03 20:23:06
Committer: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> 2013-01-16 
12:00:15

Follows: v3.8-rc3
Precedes: next-20130117

     TTY: switch tty_flip_buffer_push
