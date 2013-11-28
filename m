From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
Date: Wed, 27 Nov 2013 18:46:28 -0800
Message-ID: <CAAYSxhquguBiqczOieDYCsgtMLLdkA-2hakJ9qZaCBpL_r8paw@mail.gmail.com>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
	<20131126183559.GA18570@localhost>
	<CAAYSxhqU9GZdaoTjoCAeyQ4h-KPVzU0BH0D1eLYJoFZ+s8tPgQ@mail.gmail.com>
	<20131127185448.GA21422@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131127185448.GA21422@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patch Tracking <patches@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 27, 2013 at 10:54 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Tue, Nov 26, 2013 at 03:03:03PM -0800, Tim Kryger wrote:

>> An external device may be keeping the UART busy and preventing LCR
>> from being written.
>>
>> What device is attached to ttyS1?
>
> There's no device attached at ttyS1. I've just tested this in another
> box and it seems the same error is obtained on each unused port:

Do you know if your UART pins have pull up resistors?

If you can, try attaching something to an unused port.

-Tim
