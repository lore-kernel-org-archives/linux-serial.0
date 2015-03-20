From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] serial: 8250_dw: fix 'cts-override'
Date: Fri, 20 Mar 2015 11:00:43 -0700
Message-ID: <CAE_wzQ_Qx=-yg0y3SLKe1Q=TroTQ0cq-sQ3dysp7raQmGjBahw@mail.gmail.com>
References: <20150310003731.GA21791@dtor-ws>
	<20150311130053.GA16733@kroah.com>
	<CAE_wzQ9VnrmPKfdxpZsQFT5tEhekTFobTQBNBVRMWVE6cbRAoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE_wzQ9VnrmPKfdxpZsQFT5tEhekTFobTQBNBVRMWVE6cbRAoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Cernekee <cernekee@chromium.org>, "JD (Jiandong) Zheng" <jdzheng@broadcom.com>, Ray Jui <rjui@broadcom.com>, Desmond Liu <desmondl@broadcom.com>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On Wed, Mar 11, 2015 at 10:25 AM, Dmitry Torokhov <dtor@chromium.org> wrote:
> Hi Greg,
>
> On Wed, Mar 11, 2015 at 6:00 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Mon, Mar 09, 2015 at 05:37:31PM -0700, Dmitry Torokhov wrote:
>>> We are dealing with CTS, not DSR here (we dealt with DSR a few lines
>>> above), so set appropriate bits.
>>>
>>> Reported-by: Kevin Cernekee <cernekee@chromium.org>
>>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>>> ---
>>>  drivers/tty/serial/8250/8250_dw.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> Should this go into 4.0-final, or can it wait for 4.1-rc1?
>> I'm guessing 4.0-final, but want to make sure.
>
> I'd like to have it in 4.0 but since there are no users of the feature
> in mainline yet I think it can wait.
>

Could you please pick it for 4.1?

Thanks,
Dmitry
