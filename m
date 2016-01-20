From: Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Wed, 20 Jan 2016 23:09:39 +0300
Message-ID: <691920039.20160120230939@cogentembedded.com>
References: <20150511013540.5709.93626.stgit@notabene.brown>
  <CAAObsKD7-02HVUosXVwqcH6HyGEGYJ9jdNepuNhLiiL+ujO5iw@mail.gmail.com>
  <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
  <20160113191542.GA12086@leverpostej>
  <1CD6CA14-AE4F-444F-A9A2-CF9B9485F2DC@goldelico.com>
  <20160115110106.GA3262@leverpostej>
  <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
  <569913A1.80606@cogentembedded.com>
  <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com>
  <56992959.2020204@hurleysoftware.com>
  <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
  <744620565.20160116103445@cogentembedded.com>
  <CAKdAkRQh7xSgOXERhA8EjXEfX5m-PTTjiv757X7FYxK=bhfpww@mail.gmail.com>
Reply-To: Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdAkRQh7xSgOXERhA8EjXEfX5m-PTTjiv757X7FYxK=bhfpww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Tomeu Vizoso <tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi, Dmitry.

> On Fri, Jan 15, 2016 at 11:34 PM, Vostrikov Andrey
> <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org> wrote:
>>
>> Yes, such implementation will help. There is a need for interface like UART BUS that will probe devices without user space.
>> Serial I/O for input subsystem defines new type of bus and uses dedicated line discipline, but it still unable to start driver by itself and requires call from 'inputattach' to open port, assign line discipline and go to forever wait on 'read'.

> That was done mainly because almost none of the serial protocols could
> be auto-probed, so device initialization/setup was moved out of kernel
> and thus we have the separate line discipline and inputattach utility.

This  is understandable for "dummy" devices like mice, that only
report input events.

But  in  case there is "intellectual" MCU, that must reply on specific
commands  with specific response - it could be auto-probed. Especially
when it is hardwired. Unfortunately, there  is  no  API  to  do  it.
Opening  port and attaching line discipline  from  kernel  side
does  not  look good. The only example is '/dev/console', which is
implemented that way.

> Thanks.

-- 
Best regards,
Andrey Vostrikov

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
