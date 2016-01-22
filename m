From: Tomeu Vizoso <tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org>
Subject: Re: [Gta04-owner] [PATCH 0/4] UART slave device support - version 4
Date: Fri, 22 Jan 2016 16:45:38 +0100
Message-ID: <CAAObsKB4oFeM9Cjet5z+vz0S1M8RZ3jFt03b38KXq+sh6f5EwA@mail.gmail.com>
References: <481E05A9-A192-438D-B092-D7700B30BBC4@goldelico.com>
 <20160115110106.GA3262@leverpostej> <69F8E1E5-EF49-4C8E-88E9-973F82F7102E@goldelico.com>
 <569913A1.80606@cogentembedded.com> <CB69F6F0-B40B-47D1-B175-8401F43288C5@goldelico.com>
 <56992959.2020204@hurleysoftware.com> <CAL_JsqL=Wotz4FuoV7PULfZNfSV=S_q0iOzkckVA3NDDzMdfZQ@mail.gmail.com>
 <744620565.20160116103445@cogentembedded.com> <20160116233157.GA7774@rob-hp-laptop>
 <3D5F35D7-31B5-4E68-875F-7DD492EF0316@goldelico.com> <20160117141912.4aa2e46c@lxorguk.ukuu.org.uk>
 <1D5F146E-D347-453B-9158-8D269F8DA99C@goldelico.com> <20160117193849.69d00c28@lxorguk.ukuu.org.uk>
 <37DCE36D-0A5E-41C5-BDA4-857DCF9F2DD1@goldelico.com> <20160118111926.0882b422@lxorguk.ukuu.org.uk>
 <07F3B6C0-0C87-478C-B6DD-5C0EECB42D0D@goldelico.com> <20160118220319.051c9cc0@lxorguk.ukuu.org.uk>
 <C1E6AFE7-1EF2-4C70-8BE2-82F5CD7DDE22@goldelico.com> <9E37C552-361C-4A54-980E-E3BFFF834302@goldelico.com>
 <20160120174610.1c64239a@lxorguk.ukuu.org.uk> <39B850CE-E381-4D3B-BD0A-84AFE7DAEEDF@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <39B850CE-E381-4D3B-BD0A-84AFE7DAEEDF-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vostrikov Andrey <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, List for communicating with real GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 20 January 2016 at 19:03, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>
> Am 20.01.2016 um 18:46 schrieb One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:
>
>>> The problem is that *I* have no control over user space. But I also don't want
>>> to say to my users "that is not my problem - get it solved yourself". This does
>>> not help them.
>>
>> Stuffing things into the kernel because the user space of a given
>> platform can't get itself organised isn't helpful to the other billion
>> plus Linux devices out there.
>
> The assumption that there is  "the" user space of a given platform is wrong.

I'm a bit surprised at the arguments being exchanged here regarding
why the kernel may or may not deal with the detail that a (say) BT
chip is behind a uart.

I would have expected that the main (and IMO sufficient) reason why
the kernel should do it is because the particular bus used to connect
a BT chip to the CPU is a hw detail that a kernel that does its job
should keep to itself. Same as userspace not needing to care if a BT
chip is behind SDIO or USB, why does it have to tell the kernel behind
which UART a BT chip is sitting?

Regards,

Tomeu
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
