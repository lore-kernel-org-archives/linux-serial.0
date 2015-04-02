From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
Date: Thu, 02 Apr 2015 11:35:01 -0400
Message-ID: <551D61A5.8000604@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com> <CAL_JsqKQD2ivpZ5kOy8ehmzsdFy8EMFZ-KvO2QS3fxtLgQL8Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKQD2ivpZ5kOy8ehmzsdFy8EMFZ-KvO2QS3fxtLgQL8Lw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 04/02/2015 09:46 AM, Rob Herring wrote:
> Sorry about that. I had thought about doing the same thing. At least
> unifying the macros, but not necessarily the tables. If it is also
> extendable to other firmware interfaces like ACPI perhaps that would
> be good.

No need to apologize; I'll make those changes and resubmit for your
review.

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
