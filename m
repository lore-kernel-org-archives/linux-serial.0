From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] devicetree: bindings: uart: Add new compatible string
 for ZynqMP
Date: Wed, 5 Oct 2016 07:52:09 -0500
Message-ID: <CAL_Jsq+RJbHmayX8HdoWzPxxCrGKZjjyRQrwPzSmdOnHTKkC2Q@mail.gmail.com>
References: <1474898801-36571-1-git-send-email-navam@xilinx.com>
 <20161003184234.GA13165@rob-hp-laptop> <C89496FEAE474D468F30D558A9468D9F26D2AB89@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C89496FEAE474D468F30D558A9468D9F26D2AB89-4lKfpRxZ5enZMOc0yg5rMog+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nava kishore Manne <nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "jslaby-IBi9RG/b67k@public.gmane.org" <jslaby-IBi9RG/b67k@public.gmane.org>, "michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 5, 2016 at 7:23 AM, Nava kishore Manne
<nava.manne-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> Hi Rob,
>
>         Thanks for the review...
>
>> > Changes for v5:
>> >             -Fixed some minor comments.
>>
>> Not a useful changelog. The point of these comments is to remind the
>> reviewers of what they commented on.
>
> Ok will take care from next version onwards...
>
>> >  Required properties:
>> > -- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
>> > +- compatible :
>> > +  Use "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq-7xxx SoC.
>>
>> This is still not right. It was wrong before, but you are touching it so make it
>> right.
>>
>> OR doesn't match the dts files. It is AND and the opposite order.
>>
>> xlnx,xuartps wasn't the best naming, but it's in use so we'll have to live with it
>> for zynq-7xxx.
>>
>> > +  Use "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.
>>
>> What I meant here was this should have something like "xlnx,mpsoc-uart"
>> as the first compatible with "cdns,uart-r1p12" as the second. Not sure if
>> "mpsoc" is the best name here.
>
> You mean something like below
>  Use "xlnx,xuartps" or "cdns,uart-r1p8" for Zynq-7xxx SoC.

As I said, it is not an OR condition. 'Use "xlnx,xuartps",
"cdns,uart-r1p8" for Zynq-7xxx SoC

> Use "xlnx,zynqmp-uart" or " cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.

Yes, but as above.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
