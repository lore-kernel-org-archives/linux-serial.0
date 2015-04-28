From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v3 01/13] of: earlycon: Fix 'stdout-path' with ':' path terminator
Date: Tue, 28 Apr 2015 09:02:23 -0500
Message-ID: <CAL_JsqL782WjWNOQHra7wcuugQVF-btwmUitx-7umBmnSOzK1A@mail.gmail.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1428515119-25248-2-git-send-email-peter@hurleysoftware.com>
 <CAL_JsqLvKVDTD9-ees=gynVD2WDtEPGAa+XPCCpkX9ydaAVyTw@mail.gmail.com>
 <553F862A.2000709@hurleysoftware.com> <20150428132838.GA10782@kroah.com> <553F91F8.3010400@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <553F91F8.3010400@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 28, 2015 at 8:58 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 04/28/2015 09:28 AM, Greg Kroah-Hartman wrote:
>> On Tue, Apr 28, 2015 at 09:07:54AM -0400, Peter Hurley wrote:
>>> On 04/08/2015 05:24 PM, Rob Herring wrote:
>>>> On Wed, Apr 8, 2015 at 12:45 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>> stdout-path defines ':' as a path terminator and commit 75c28c09af99a
>>>>> ("of: add optional options parameter to of_find_node_by_path()") added
>>>>> the necessary support to parse paths terminated with ':'.
>>>>> commit 7914a7c5651a5 ("of: support passing console options with
>>>>> stdout-path") added options string support to the stdout-path property,
>>>>> which broke earlycon.
>>>>>
>>>>> Add the same support to earlycon to process 'stdout-path' properties
>>>>> which contain an options string.
>>>>>
>>>>> Requires: "libfdt: Add fdt_path_offset_namelen()"
>>>>
>>>> Since David has applied this, we can cherrypick that commit for the
>>>> kernel copy. Ideally, we would do a dtc sync, but it's not going to
>>>> happen for 4.1.
>>>
>>> Rob,
>>>
>>> Greg pulled this series for -next and kbuild robot promptly blew up
>>> because of this missing commit. Are you planning on cherry-picking
>>> "libfdt: Add fdt_path_offset_namelen()"?
>>
>> Can I just take that patch so I don't see the build issues in my branch?
>
> It's ok with me, fwiw.
>
> However, you should be aware that the patch is for the out-of-tree
> devicetree compiler at git://git.kernel.org/pub/scm/utils/dtc/dtc.git,
> which is not the same as in-tree compiler.
>
> I could send you an edited patch that applies cleanly to the
> in-tree compiler but I don't know how Rob and Grant feel about that.

That is what I suggested above if it was for 4.1. I would like to get
a full sync of dtc done for 4.2 though. Give me a few days and I'll
try to get that done.

Rob
