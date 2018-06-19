From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH 4/8] mailbox: tegra-hsp: Refactor in preparation of
 mailboxes
Date: Tue, 19 Jun 2018 15:52:23 +0300
Message-ID: <11fd8a32-87f1-6e90-fa1e-9399d5222611@kapsi.fi>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-5-mperttunen@nvidia.com>
 <8306b033-e7f5-748c-6e6a-131dfd6a26b8@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8306b033-e7f5-748c-6e6a-131dfd6a26b8@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com
Cc: araza@nvidia.com, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 22.05.2018 18:36, Jon Hunter wrote:
> 
> On 08/05/18 12:43, Mikko Perttunen wrote:
>> The HSP driver is currently in many places written with the assumption
>> of only supporting doorbells. Prepare for the addition of shared
>> mailbox support by removing these assumptions and cleaning up the code.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/mailbox/tegra-hsp.c | 124 
>> +++++++++++++++++++++++++++++---------------
>>   1 file changed, 82 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
>> index 0cde356c11ab..16eb970f2c9f 100644
>> --- a/drivers/mailbox/tegra-hsp.c
>> +++ b/drivers/mailbox/tegra-hsp.c
>> @@ -1,5 +1,5 @@
>>   /*
>> - * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
>> + * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
>>    *
>>    * This program is free software; you can redistribute it and/or 
>> modify it
>>    * under the terms and conditions of the GNU General Public License,
>> @@ -42,6 +42,7 @@ struct tegra_hsp_channel;
>>   struct tegra_hsp;
>>   struct tegra_hsp_channel {
>> +    unsigned int type;
>>       struct tegra_hsp *hsp;
>>       struct mbox_chan *chan;
>>       void __iomem *regs;
>> @@ -55,6 +56,12 @@ struct tegra_hsp_doorbell {
>>       unsigned int index;
>>   };
>> +static inline struct tegra_hsp_doorbell *
>> +channel_to_doorbell(struct tegra_hsp_channel *channel)
>> +{
>> +    return container_of(channel, struct tegra_hsp_doorbell, channel);
>> +}
>> +
>>   struct tegra_hsp_db_map {
>>       const char *name;
>>       unsigned int master;
>> @@ -69,7 +76,7 @@ struct tegra_hsp {
>>       const struct tegra_hsp_soc *soc;
>>       struct mbox_controller mbox;
>>       void __iomem *regs;
>> -    unsigned int irq;
>> +    unsigned int doorbell_irq;
>>       unsigned int num_sm;
>>       unsigned int num_as;
>>       unsigned int num_ss;
>> @@ -194,7 +201,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, 
>> const char *name,
>>       if (!db)
>>           return ERR_PTR(-ENOMEM);
>> -    offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) << 16;
>> +    offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * 
>> SZ_64K;
>>       offset += index * 0x100;
>>       db->channel.regs = hsp->regs + offset;
>> @@ -218,18 +225,8 @@ static void __tegra_hsp_doorbell_destroy(struct 
>> tegra_hsp_doorbell *db)
>>       kfree(db);
>>   }
>> -static int tegra_hsp_doorbell_send_data(struct mbox_chan *chan, void 
>> *data)
>> -{
>> -    struct tegra_hsp_doorbell *db = chan->con_priv;
>> -
>> -    tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
>> -
>> -    return 0;
>> -}
>> -
>> -static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
>> +static int tegra_hsp_doorbell_startup(struct tegra_hsp_doorbell *db)
>>   {
>> -    struct tegra_hsp_doorbell *db = chan->con_priv;
>>       struct tegra_hsp *hsp = db->channel.hsp;
>>       struct tegra_hsp_doorbell *ccplex;
>>       unsigned long flags;
>> @@ -260,9 +257,8 @@ static int tegra_hsp_doorbell_startup(struct 
>> mbox_chan *chan)
>>       return 0;
>>   }
>> -static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
>> +static void tegra_hsp_doorbell_shutdown(struct tegra_hsp_doorbell *db)
>>   {
>> -    struct tegra_hsp_doorbell *db = chan->con_priv;
>>       struct tegra_hsp *hsp = db->channel.hsp;
>>       struct tegra_hsp_doorbell *ccplex;
>>       unsigned long flags;
>> @@ -281,35 +277,61 @@ static void tegra_hsp_doorbell_shutdown(struct 
>> mbox_chan *chan)
>>       spin_unlock_irqrestore(&hsp->lock, flags);
>>   }
>> -static const struct mbox_chan_ops tegra_hsp_doorbell_ops = {
>> -    .send_data = tegra_hsp_doorbell_send_data,
>> -    .startup = tegra_hsp_doorbell_startup,
>> -    .shutdown = tegra_hsp_doorbell_shutdown,
>> +static int tegra_hsp_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +    struct tegra_hsp_channel *channel = chan->con_priv;
>> +    struct tegra_hsp_doorbell *db;
>> +
>> +    switch (channel->type) {
>> +    case TEGRA_HSP_MBOX_TYPE_DB:
>> +        db = channel_to_doorbell(channel);
>> +        tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
> 
> The above appears to be redundant. We go from channel to db and then end 
> up passing channels. Do we really need the 'db' struct above?

Fixed.

> 
>> +    }
>> +
>> +    return -EINVAL;
> 
> Does this function always return -EINVAL?

Fixed.

> 
>> +}
>> +
>> +static int tegra_hsp_startup(struct mbox_chan *chan)
>> +{
>> +    struct tegra_hsp_channel *channel = chan->con_priv;
>> +
>> +    switch (channel->type) {
>> +    case TEGRA_HSP_MBOX_TYPE_DB:
>> +        return tegra_hsp_doorbell_startup(channel_to_doorbell(channel));
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static void tegra_hsp_shutdown(struct mbox_chan *chan)
>> +{
>> +    struct tegra_hsp_channel *channel = chan->con_priv;
>> +
>> +    switch (channel->type) {
>> +    case TEGRA_HSP_MBOX_TYPE_DB:
>> +        tegra_hsp_doorbell_shutdown(channel_to_doorbell(channel));
>> +        break;
>> +    }
>> +}
>> +
>> +static const struct mbox_chan_ops tegra_hsp_ops = {
>> +    .send_data = tegra_hsp_send_data,
>> +    .startup = tegra_hsp_startup,
>> +    .shutdown = tegra_hsp_shutdown,
>>   };
>> -static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller 
>> *mbox,
>> -                        const struct of_phandle_args *args)
>> +static struct mbox_chan *tegra_hsp_doorbell_xlate(struct tegra_hsp *hsp,
>> +                          unsigned int master)
>>   {
>>       struct tegra_hsp_channel *channel = ERR_PTR(-ENODEV);
>> -    struct tegra_hsp *hsp = to_tegra_hsp(mbox);
>> -    unsigned int type = args->args[0];
>> -    unsigned int master = args->args[1];
>>       struct tegra_hsp_doorbell *db;
>>       struct mbox_chan *chan;
>>       unsigned long flags;
>>       unsigned int i;
>> -    switch (type) {
>> -    case TEGRA_HSP_MBOX_TYPE_DB:
>> -        db = tegra_hsp_doorbell_get(hsp, master);
>> -        if (db)
>> -            channel = &db->channel;
>> -
>> -        break;
>> -
>> -    default:
>> -        break;
>> -    }
>> +    db = tegra_hsp_doorbell_get(hsp, master);
>> +    if (db)
>> +        channel = &db->channel;
>>       if (IS_ERR(channel))
>>           return ERR_CAST(channel);
>> @@ -321,6 +343,7 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct 
>> mbox_controller *mbox,
>>           if (!chan->con_priv) {
>>               chan->con_priv = channel;
>>               channel->chan = chan;
>> +            channel->type = TEGRA_HSP_MBOX_TYPE_DB;
>>               break;
> 
> I see that you are making the above only used for doorbells, but don't 
> we still need to set the chan->con_priv for shared mailboxes as well?

That's done elsewhere in the next patch that actually adds the shared 
mailbox support.

> 
> Cheers
> Jon
> 

Thanks,
Mikko
