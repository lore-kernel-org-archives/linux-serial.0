From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH v3 2/2] serdev: Update drivers/bluetooth/Kconfig for ACPI
 serdev support
Date: Tue, 10 Oct 2017 18:16:46 +1100
Message-ID: <CAFXWsS8=t9SfUdWPOSpmHt4-6cgdrVtQChryyzJ74XOQQP3-Ww@mail.gmail.com>
References: <dc9cecc0-d9ef-109f-5f05-cf77ab16e60e@gmail.com>
 <427a95f6-feda-e93e-9a0f-a05b7b339ee6@gmail.com> <20171009080606.GO2618@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171009080606.GO2618@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

On 9 October 2017 at 19:06, Johan Hovold <johan@kernel.org> wrote:
> On Mon, Oct 09, 2017 at 11:43:31AM +1100, Ian W MORRISON wrote:
<snip>
>>
>> This patch set addresses this by making BT_HCIUART_BCM dependent on
>> SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS
>> and ensures that if SERIAL_DEV_BUS is selected is the code is build it.
>
> Ok, so you didn't even bother to write two distinct commit messages for
> your two patches, and my comments to the first patch apply also here.
>
<snip>
>
> Johan

Hi Johan,

My experience in submitting patches is still limited and I am very
much learning so thanks for the helpful comments and apologies for
trying your patience. My keenness on submitting patches was to show
that I had tested my suggestions so as to given them credibility
rather than any attempt to own the patch.

What I was trying to do here was to suggested two patches with one
requiring the other. Rather than keep as a single patch affecting two
files I separated into two patches attempting to create a patch series
with a single changelog. This was the wrong approach and I may have
misled so apologies for that.

Regards,
Ian
